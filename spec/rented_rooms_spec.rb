require_relative "../lib/rented_rooms"
require "user"

describe Rented_rooms do
  describe "#request_room" do
    it "selects a room and creates a message for the owner" do
      p rented_room = Rented_rooms.request_room(user_id: 1, room_id: 2, occupied_date: "2021-10-14")

      expect(rented_room.room_id).to eq "2"
      expect(rented_room.user_id).to eq "1"
      expect(rented_room.occupied_date).to eq "2021-10-14"
      expect(rented_room.approved).to eq false
    end

    it "does not allow same user to book the same room on the same day" do
      rented_room = Rented_rooms.request_room(user_id: 1, room_id: 2, occupied_date: "2021-10-14")
      Rented_rooms.request_room(user_id: 1, room_id: 2, occupied_date: "2021-10-14")
      result = PG.connect(dbname: "makersbnb_test").query("SELECT * FROM rented_rooms WHERE occupied_date = '2021-10-14' AND room_id = #{2} AND user_id = #{1}")
      expect(result.ntuples).to eq 1
    end
  end

  describe "#approve_request" do
    it "approves the request" do
      user = User.add(name: "Larry", password: "12345678")
      room = Room.add(user_id:user.id, title: "under-stairs cupboard", description: "a cupboard under the stairs", price: 999, location: "The Potter household")
      booking = Rented_rooms.request_room(user_id:1, room_id: room.id, occupied_date: "1999-10-9")
      Rented_rooms.approve_request(id: booking.id, approval: true)
      connection = PG.connect(dbname: "makersbnb_test")

      result = connection.query("SELECT * FROM rented_rooms WHERE id = #{booking.id}")
      expect(result[0]["approved"]).to eq "t"
      #expect(booking.approved).to eq true
    end

    it "rejects the request" do
      user = User.add(name: "Larry", password: "12345678")
      room = Room.add(user_id:user.id, title: "under-stairs cupboard", description: "a cupboard under the stairs", price: 999, location: "The Potter household")
      booking = Rented_rooms.request_room(user_id:1, room_id: room.id, occupied_date: "1999-10-9")
      Rented_rooms.approve_request(id: booking.id, approval: false)
      connection = PG.connect(dbname: "makersbnb_test")

      result = connection.query("SELECT * FROM rented_rooms WHERE id = #{booking.id}")
      expect(result.ntuples).to eq 0
    end

    it "rejects all requests when one is approved on the same date" do
      user = User.add(name: "Larry", password: "12345678")
      room = Room.add(user_id:user.id, title: "under-stairs cupboard", description: "a cupboard under the stairs", price: 999, location: "The Potter household")
      
      booking = Rented_rooms.request_room(user_id:1, room_id: room.id, occupied_date: "1999-10-9")
      Rented_rooms.request_room(user_id:2, room_id: room.id, occupied_date: "1999-10-9")
      Rented_rooms.approve_request(id: booking.id, approval: true)

      connection = PG.connect(dbname: "makersbnb_test")

      result = connection.query("SELECT * FROM rented_rooms WHERE occupied_date = '1999-10-9' AND room_id = #{room.id}")
      expect(result.ntuples).to eq 1
    end
  end
end