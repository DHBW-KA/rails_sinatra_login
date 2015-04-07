require "test_helper"

describe 'Session' do
  def test_new
    get :new
    assert_response :success
    assert_not_nil assigns(:user)
    assert_select 'form.ui.form input', 4
  end

  def test_create
    get :create, {user: {name: 'nobody'}}
    assert_response :success
  end

end
