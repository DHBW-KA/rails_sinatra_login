require 'bundler'
Bundler.require :default, (ENV['RACK_ENV'] || 'development').to_sym

$LOAD_PATH << 'app'
require 'routes.rb'