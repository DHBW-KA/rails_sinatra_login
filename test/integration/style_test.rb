
describe 'StyleTest' do

  it 'Application has a navbar' do
    get login_path
    assert_select '.ui.menu'
    assert_select 'a', 'Home'
  end

end