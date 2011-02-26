require 'rubygems'
require 'sinatra'
require 'erb'
require 'mongo'
require 'uri'

## config
  config = Hash.new
  config[:database] = "graylog2"
##
  
db = Mongo::Connection.new.db(config[:database])

skipped_collections = ["system.users", "system.indexes", "system.profile"]

get '/' do
  @database_name = config[:database]
  @collection_names = db.collection_names
  skipped_collections.each { |collection| @collection_names.delete(collection) }

  case db.profiling_level
    when :off then @profiling_level = "Off"
    when :slow_only then @profiling_level = "Slow only"
    when :all then @profiling_level = "Full"
    else @profiling_level = "Unknown"
  end
 
  # Slow queries. (Converted to array and flipped for better readable order)
  @slow_queries = db.profiling_info.to_a.reverse

  @stats = db.stats

  erb :home
end

get '/indexes/:collection' do
  coll = db.collection(params[:collection])
  @indexes = coll.index_information

  erb :indexes
end

# should be a post, but fuck this shit.
get '/profiling_level/:what' do
  allowed_types = [:off, :slow_only, :all]
  what = params[:what].to_sym

  if allowed_types.include?(what)
    db.profiling_level = what
    redirect "/"
  else
    "Not allowed profiling level: #{what}. Allowed: #{allowed_types.inspect}"
  end
end

get '/drop_index/:collection/:index' do
  coll = db.collection(params[:collection])
  coll.drop_index(params[:index])
  redirect "/indexes/#{URI.escape(params[:collection])}"
end

post '/add_index/:collection' do
  if params[:ordering] == nil or params[:ordering].length == 0
    ordering = Mongo::ASCENDING
  else
    case (params[:ordering])
      when "ascending" then ordering = Mongo::ASCENDING
      when "descending" then ordering = Mongo::DESCENDING
      else ordering = Mongo::ASCENDING
    end
  end

  options = Hash.new
  options[:unique] = true if params[:unique] != nil and params[:unique] == "true"
  options[:background] = true if params[:background] != nil and params[:background] == "true"

  coll = db.collection(params[:collection])
  coll.create_index([[params[:index], ordering]], options)

  redirect "/indexes/#{URI.escape(params[:collection])}"
end
