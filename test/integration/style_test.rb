require 'test_helper'

describe 'StyleTest' do

  it 'Application has a navbar' do
    get '/login'
    assert_response :ok
    assert_select '.ui.menu'
    assert_select 'a', 'Home'
  end

end