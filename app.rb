$LOAD_PATH << 'app'
ENV['RACK_ENV'] ||= 'development'

require 'bundler'
Bundler.require :default, ENV['RACK_ENV'].to_sym
require 'json'

ActiveRecord::Base.establish_connection(YAML.load(File.read('./config/database.yml'))[ENV['RACK_ENV']])

require_relative 'config/application'
require 'routes.rb'