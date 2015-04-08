require "test_helper"

describe 'UsersController' do

  before {
    env "rack.session", {user: users(:admin).id }
  }
  def user
    @user ||= users :one
  end

  def test_index
    get :index
    assert_equal 200, response.status
    assert_not_nil assigns(:users)
  end

  it 'looks nice' do
    get :index
    assert_select 'table.ui.table'
  end

  def test_new
    get :new
    assert_equal 200, response.status
  end

  def test_create
    count = User.count
    post :create, user: { email: user.email, name: user.name, password_digest: user.password_digest }
    assert_equal count+1, User.count

    assert_redirected_to user_path(assigns(:user))
  end

  def test_show
    get :show, id: user
    assert_equal 200, response.status
  end

  def test_edit
    get :edit, id: user
    assert_equal 200, response.status
  end

  def test_update
    put :update, id: user, user: { email: user.email, name: user.name, password_digest: user.password_digest }
    assert last_response.redirect?, "Redirect expected but status was <#{last_response.status}>"
    follow_redirect!
    assert_equal "users/#{user.id}", last_request.fullpath
  end

  def test_destroy
    count = User.count
    delete :destroy, id: user
    assert_equal count-1, User.count

    assert_equal "/users", last_request.fullpath
  end

  it 'updates with invalid data' do
    put :update, id: user, user: {email: 'abcd'}
    assert_select 'ul > li', 'Email is invalid'
  end

  it 'creates an invalid user' do
    post :create, user: {email: 'asd'}
    assert_select 'ul > li', 'Email is invalid'
  end
end
