require "test_helper"

describe 'Session' do
  it 'shows the form for a new session' do
    get :new
    assert_equal 200, response.status
    assert_not_nil assigns(:user)
    assert_select 'form.ui.form input', 4
  end

  it 'can create a new session' do
    get :create, {user: {name: 'nobody'}}
    assert_equal 200, response.status
  end

end
