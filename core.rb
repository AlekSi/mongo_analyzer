require 'rubygems'
require 'sinatra'
require 'erb'
require 'mongo'

## config
  config = Hash.new
  config[:database] = "graylog2"
##

db = Mongo::Connection.new.db(config[:database])

get '/' do
  @database_name = config[:database]

  case db.profiling_level
    when :off then @profiling_level = "Off"
    when :slow_only then @profiling_level = "Slow only"
    when :all then @profiling_level = "Full"
    else @profiling_level = "Unknown"
  end
 
  # Slow queries. (Converted to array and flipped for better readable order)
  @slow_queries = db.profiling_info.to_a.reverse

  @stats = db.stats

  erb :index
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
