require 'test_helper'

describe User do

  subject { User.new }
  it 'is the right class' do
    assert_equal ActiveRecord::Base, subject.class.superclass
  end

end