require "web_helpers"

feature "sign in" do
  scenario "User signs in to existing account" do
    visit "/signin"
    fill_in("username", with: "Dave")
    fill_in("password", with: "12345678")
    click_button "Sign in"
    expect(page).to have_current_path("/rooms")
    expect(page).to have_content("Dave")
  end

  scenario "User signs in to non-existant account" do
    visit "/signin"
    fill_in("username", with: "Fred")
    fill_in("password", with: "12345678")
    click_button "Sign in"

    expect(page).to have_current_path("/signin")
    expect(page).to have_content("Account not recognised")
  end
end
