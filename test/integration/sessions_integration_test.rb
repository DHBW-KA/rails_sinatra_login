describe 'SessionsIntegrationTest' do

  def login
    post '/login', {user: {name: 'admin', password: 'admin'}}, 'rack.session' => session
  end

  it 'cant see users index without login' do
    get '/'
    assert_nil session[:user]
    assert_equal '/login', last_request.fullpath
    assert_select '.ui.message', 'Please login'
  end

  it 'can login' do
    get '/login'
    assert_nil session[:user]
    login
    assert !session[:user].nil?
    assert_equal '/', last_request.fullpath
    assert_select '.ui.message', 'Login Successful'
    assert_select 'a', 'Logout'
  end

  it 'cant login' do
    post '/login', {user: {name: 'evil', password: 'none'}}, 'rack.session' => session
    assert_equal '/login', last_request.fullpath
    assert_select '.ui.message', 'Wrong Name or Password'
  end
end