require 'test_helper'

describe 'SessionsIntegrationTest' do

  def login
    post '/login', {user: {name: 'admin', password: 'admin'}}, 'rack.session' => session
  end

  it 'cant see users index without login' do
    get '/'
    assert_nil session[:user]
    assert_response :redirect
    follow_redirect!
    assert_equal '/login', last_request.fullpath
    assert_select '.ui.message', 'Please login'
  end

  it 'can login' do
    get '/login'
    assert_nil session[:user]
    login
    assert_equal users(:admin).id, session[:user]
    assert_response :redirect
    follow_redirect!
    assert_equal '/', last_request.fullpath
    assert_select '.ui.message', 'Login Successful'
    assert_select 'a', 'Logout'
  end

  it 'cant login' do
    post '/login', {user: {name: 'evil', password: 'none'}}, 'rack.session' => {}
    assert_equal '/login', last_request.fullpath
    assert_select '.ui.message', 'Wrong Name or Password'
  end

  it 'can logout' do
    get '/login'
    login
    follow_redirect!
    assert_equal users(:admin).id, session[:user]
    assert_select 'a', 'Logout'
    get '/logout'
    assert_equal nil, session[:user]
  end
end