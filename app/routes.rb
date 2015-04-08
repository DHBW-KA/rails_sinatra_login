Dir.glob("#{File.expand_path('../', __FILE__)}/**/*.rb", &method(:require))

get '/' do
  'Hello World'
end