def signin
  visit '/signin'
  fill_in('username', with: 'parsle')
  click_button 'Sign in'
end
