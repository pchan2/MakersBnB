feature "Approval" do
  scenario "accept approval requests" do
    signin
    room = Room.add(user_id: 3, title: "under-stairs cupboard", description: "a cupboard under the stairs", price: 999, location: "The Potter household")
    booking = Rented_rooms.request_room(user_id: 1, room_id: room.id, occupied_date: "1999-10-9")
    visit :"/approvals"
    click_button 'approve'

    connection = PG.connect(dbname: "makersbnb_test")
    result = connection.query("SELECT * FROM rented_rooms WHERE id = #{booking.id}")
    expect(result[0]["approved"]).to eq "t"
    #expect(booking.approved).to eq true
  end

  scenario "decline approval requests" do
    signin
    room = Room.add(user_id: 3, title: "under-stairs cupboard", description: "a cupboard under the stairs", price: 999, location: "The Potter household")
    booking = Rented_rooms.request_room(user_id: 1, room_id: room.id, occupied_date: "1999-10-9")
    visit :"/approvals"
    click_button 'decline'

    connection = PG.connect(dbname: "makersbnb_test")
    result = connection.query("SELECT * FROM rented_rooms WHERE id = #{booking.id}")
    expect(result.ntuples).to eq 0
  end
end