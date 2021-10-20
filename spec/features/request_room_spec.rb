feature "Request room" do
  scenario "A user can request to book an existing room" do
    signin

    fill_in("title", with: "castle")
    fill_in("occupied_date", with: "2021-10-19")
    click_button "Submit"

    connection = PG.connect(dbname: "makersbnb_test")
    user_id = connection.exec("SELECT id FROM users WHERE name = 'parsle';")

    # expect(page).to include "castle"
    # expect(page).to include ""
    expect(page).to have_content "2021-10-19"
    # expect(page).to include false
  end
end
