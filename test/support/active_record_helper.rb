class MiniTest::Test
  include ActiveRecord::TestFixtures
  self.fixture_path = "#{test_root}/fixtures"
  self.pre_loaded_fixtures = true
  fixtures :all

  def method_name
    @NAME
  end

end