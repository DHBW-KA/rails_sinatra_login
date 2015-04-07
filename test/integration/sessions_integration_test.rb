describe 'SessionsIntegrationTest' do

  def login
    post_via_redirect login_path, {user: {name: 'admin', password: 'admin'}}
  end

  it 'cant see users index without login' do
    get_via_redirect root_path
    assert_nil session[:user]
    assert_equal login_path, request.original_fullpath
    assert_select '.ui.message', 'Please login'
  end

  it 'can login' do
    get login_path
    assert_nil session[:user]
    login
    assert_not_nil session[:user]
    assert_equal root_path, request.original_fullpath
    assert_select '.ui.message', 'Login Successful'
    assert_select 'a', 'Logout'
  end

  it 'cant login' do
    post_via_redirect login_path, {user: {name: 'evil', password: 'none'}}
    assert_equal login_path, request.original_fullpath
    assert_select '.ui.message', 'Wrong Name or Password'
  end

  it 'can login and logout' do
    visit login_path
    fill_in 'Name', with: users(:admin).name
    fill_in 'Password', with: 'admin'
    click_on 'Submit'
    page.has_content? 'Login Successful'
    click_on 'Logout'
    page.has_content? 'Logged out'
  end

end