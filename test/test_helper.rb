ENV['RACK_ENV'] = 'test'

require_relative '../app.rb'

require 'minitest/autorun'
require 'minitest/spec'
require 'minitest/pride'
require 'rack/test'

class MiniTest::Spec
  include Rack::Test::Methods
  def app
    Sinatra::Application
  end
end