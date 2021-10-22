def signin
  visit '/'
  fill_in('username', with: 'parsle')
  fill_in('password', with: '12345678')
  click_button 'Sign in'
end
