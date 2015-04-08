ENV['RACK_ENV'] = 'test'

require_relative '../app.rb'

require 'minitest/autorun'
require 'minitest/spec'
require 'minitest/pride'
require 'rack/test'

def test_root
  File.expand_path('../', __FILE__)
end

Dir.glob("#{test_root}/support/**/*.rb", &method(:require))

class MiniTest::Test
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

end