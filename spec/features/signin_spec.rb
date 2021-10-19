feature "sign in" do
  scenario "User signs in" do
    # create acc helper method
    visit '/signin'
    fill_in('username', with: 'parsle')
    click_button 'Sign in'

    persisted_data = PG.connect(dbname: 'makersbnb_test').query("SELECT * FROM users WHERE name='parsle';")
    expect(persisted_data[0]['name']).to eq 'parsle'
    expect(page).to have_content 'Welcome parsle'
  end
end
