require_relative "../lib/rented_rooms"
require "user"

describe Rented_rooms do
  describe "#request_room" do
    it "selects a room and creates a message for the owner" do
      rented_room = Rented_rooms.request_room(user_id: 1, room_id: 2, occupied_date: "2021-10-14")

      expect(rented_room.room_id).to eq "2"
      expect(rented_room.user_id).to eq "1"
      expect(rented_room.occupied_date).to eq "2021-10-14"
      expect(rented_room.approved).to eq false
      
    end


  end

  describe "#approve_request" do
    it "approves the request" do
      user = User.add(name: "Larry")
      room = Room.add(user_id:user.id, title: "under-stairs cupboard", description: "a cupboard under the stairs", price: 999, location: "The Potter household")
      booking = Rented_rooms.request_room(user_id:1, room_id: room.id, occupied_date: "1999-10-9")
      booking.approve_request(true)
      connection = PG.connect(dbname: "makersbnb_test")

      result = connection.query("SELECT * FROM rented_rooms WHERE id = #{booking.id}")
      expect(result[0]["approved"]).to eq "t"
    end

    it "rejects the request" do
      user = User.add(name: "Larry")
      room = Room.add(user_id:user.id, title: "under-stairs cupboard", description: "a cupboard under the stairs", price: 999, location: "The Potter household")
      booking = Rented_rooms.request_room(user_id:1, room_id: room.id, occupied_date: "1999-10-9")
      booking.approve_request(false)
      connection = PG.connect(dbname: "makersbnb_test")

      result = connection.query("SELECT * FROM rented_rooms WHERE id = #{booking.id}")
      expect(result.ntuples).to eq 0
    end
  end

  
end
