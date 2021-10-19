feature "sign in" do
  scenario "User signs in" do
    # create acc helper method
    visit '/signin'
    fill_in('username', with: 'parsle')
    click_button 'Sign in'

    expect(page).to have_content 'Welcome parsle'
  end
end
