feature "Request room" do
  scenario "A user can request to book an existing room" do
    signin

    fill_in "desired_date", with: "2023-11-12"
    click_button "submit"
    
    expect(page).to have_content "castle"
    expect(page).to have_content "victorian folley"

    click_button  "submit"
    expect(page).to have_content "2023-11-12"
    expect(page).to have_content "castle"
    expect(page).to have_content "victorian folley"
    expect(page).to have_content "false"

  end
end

feature "view available rooms" do
  scenario "user can see and select rooms that are available" do
    signin
    visit '/rooms'

    Room.add(user_id: 1, title: "Jane's hut", description: "Made of wood", price: 19, location: "Scotland", available_from: "2021-12-12", available_to: "2021-12-19")
    Room.add(user_id: 1, title: "Error's hut", description: "Made of wood", price: 19, location: "Scotland", available_from: "2021-11-12", available_to: "2021-11-19")
    Room.add(user_id: 2, title: "Joe's hut", description: "Made of metal", price: 19, location: "Scotland", available_from: "2021-12-12", available_to: "2021-12-19")

    fill_in "desired_date", with: "2021-12-12"
    click_button "submit"

    expect(page).to have_content "Jane's hut"
    expect(page).to have_content "Joe's hut"
    expect(page).to_not have_content "Error's hut"
    expect(page).to_not have_content "windmill"
    expect(page).to_not have_content "castle"
  end
end
