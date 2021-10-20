require 'rented_rooms'

feature "Request room" do
  scenario "A user can request to book an existing room" do
    signin

    fill_in('title', with: 'castle')
    fill_in('occupied_date', with: '2021-10-19')
    click_button 'Submit'

    connection = PG.connect(dbname: 'makersbnb_test')
    user_id = connection.exec("SELECT id FROM users WHERE name = 'parsle';")

    expect(rented_rooms.room_id).to eq "1"
    expect(rented_rooms.user_id).to eq user_id
    expect(rented_rooms.occupied_date).to eq "2021-10-19"
    expect(rented_rooms.approved).to eq false
  end
end
