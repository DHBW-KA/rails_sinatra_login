require "test_helper"

describe 'Session' do
  it 'shows the form for a new session' do
    get '/login'
    assert_response :ok
    assert_select 'form.ui.form input', 2
  end

  it 'can create a new session' do
    post '/login', {user: {name: 'nobody'}}
    assert_response :ok
  end

end
