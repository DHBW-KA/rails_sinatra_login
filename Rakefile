require_relative "app"

include ActiveRecord::Tasks

root = File.expand_path '..', __FILE__
DatabaseTasks.env = ENV['RACK_ENV'] || 'development'
DatabaseTasks.database_configuration = YAML.load(File.read(File.join(root, 'config/database.yml')))
DatabaseTasks.db_dir = File.join root, 'db'
DatabaseTasks.fixtures_path = File.join root, 'test/fixtures'
DatabaseTasks.migrations_paths = [File.join(root, 'db/migrate')]
DatabaseTasks.root = root

task :environment do
  ActiveRecord::Base.configurations = DatabaseTasks.database_configuration
  ActiveRecord::Base.establish_connection DatabaseTasks.env.to_sym
end

load 'active_record/railties/databases.rake'

require 'rake/testtask'
Rake::TestTask.new do |t|
  t.libs << 'test'
  t.pattern = "test/**/*_test.rb"
end

task default: :test