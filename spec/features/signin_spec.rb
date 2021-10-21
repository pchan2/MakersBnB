require "web_helpers"

# feature "sign in" do
#   scenario "User signs in" do
#     signin

#     persisted_data = PG.connect(dbname: 'makersbnb_test').query("SELECT * FROM users WHERE name='parsle';")
#     expect(persisted_data[0]['name']).to eq 'parsle'
#     expect(page).to have_current_path('/rooms')
#   end
# end

feature "sign in" do
  scenario "User signs in to existing account" do
    visit "/signin"
    fill_in("username", with: "Dave")
    click_button "Sign in"

    expect(page).to have_current_path("/rooms")
    expect(page).to have_content("Dave")
  end

  scenario "User signs in to non-existant account" do
    visit "/signin"
    fill_in("username", with: "Fred")
    click_button "Sign in"

    expect(page).to have_current_path("/signin")
    expect(page).to have_content("Account not recognised")
  end
end
