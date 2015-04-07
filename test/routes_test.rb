require 'test_helper'

describe 'Routes' do
  it 'can get the root path' do
    get '/'
    assert last_response.ok?
    assert_equal 'Hello World', last_response.body
  end

  let(:user){
    users(:one)
  }
  it 'can login' do
    post 'v1/account/login', email: user.email, password: user.password_digest
    assert last_response.ok?
    assert_equal({}, json)
  end
end