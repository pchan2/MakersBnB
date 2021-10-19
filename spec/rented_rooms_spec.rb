require_relative "../lib/rented_rooms"

describe Rented_rooms do
  describe "#request_room" do
    it "selects a room and creates a message for the owner" do
      rented_room = Rented_rooms.request_room(user_id: 1, room_id: 2, occupied_date: "2021-10-14")

      expect(rented_room.room_id).to eq "2"
      expect(rented_room.user_id).to eq "1"
    end
  end
end
