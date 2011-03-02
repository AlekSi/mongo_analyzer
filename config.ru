require 'rubygems'
require 'bundler'

Bundler.require

require './core.rb'
run Sinatra::Application
