require "test_helper"

describe 'UsersController' do

  before {
    env "rack.session", {user: users(:admin).id }
  }
  def user
    @user ||= users :one
  end

  def test_index
    get '/users'
    assert_response :ok
    assert_select 'table'
    assert_select 'td', User.all.sample.name
  end

  it 'looks nice' do
    get '/users'
    assert_select 'table.ui.table'
  end

  def test_new
    get '/users/new'
    assert_response :ok
  end

  def test_create
    count = User.count
    post '/users', user: { email: user.email, name: user.name, password_digest: user.password_digest }
    assert_equal count+1, User.count
    assert_response :redirect
    follow_redirect!
    assert_equal "/users", last_request.fullpath
  end

  def test_show
    get "/users/#{user.id}"
    assert_response :ok
  end

  def test_edit
    get "/users/#{user.id}/edit"
    assert_response :ok
  end

  def test_update
    put "/users/#{user.id}", user: { email: user.email, name: user.name, password_digest: user.password_digest }
    assert_response :redirect
    follow_redirect!
    assert_equal "/users/#{user.id}", last_request.fullpath
  end

  def test_destroy
    count = User.count
    delete "/users/#{user.id}"
    assert_equal count-1, User.count
    assert_response :redirect
    follow_redirect!
    assert_equal "/users", last_request.fullpath
  end

  it 'updates with invalid data' do
    put "/users/#{user.id}", user: {email: 'abcd'}
    assert_response :ok
    assert_select 'ul > li', 'Email is invalid'
  end

  it 'creates an invalid user' do
    post "/users", user: {email: 'asd'}
    assert_select 'ul > li', 'Email is invalid'
  end
end
