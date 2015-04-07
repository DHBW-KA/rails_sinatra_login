Dir.glob("#{File.expand_path('../', __FILE__)}/**/*.rb", &method(:require))


class Sinatra::Application
  register Api::Authentication
end

get '/' do
  'Hello World'
end