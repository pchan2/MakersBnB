def signin
  visit '/'
  fill_in('username', with: 'parsle')
  click_button 'Sign in'
end
