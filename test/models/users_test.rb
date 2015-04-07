require 'test_helper'

describe User do

  def user
    @user ||= User.new
  end

  it 'is valid' do
    user.password = 'asodij'
    user.email = 'valid@mail.de'
    user.valid?
    assert_equal '', user.errors.full_messages.to_sentence
  end

  it 'can store a password' do
    user = User.new
    assert user.password_digest.blank?
    assert_respond_to user, :password=
    assert_respond_to user, :password
    user.password = '123'
    user.email = 'valid@mail.de'
    user.save!
    assert_not user.password_digest.blank?
  end

end
