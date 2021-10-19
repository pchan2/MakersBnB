class Rented_rooms
  attr_reader :id, :room_id, :user_id, :occupied_date

  def initialize(id:, room_id:, user_id:, occupied_date:)
    @id = id
    @room_id = room_id
    @user_id = user_id
    @occupied_date = occupied_date
  end

  def self.request_room(user_id:, room_id:, occupied_date:)
    if ENV["RACK_ENV"] == "test"
      connection = PG.connect(dbname: "makersbnb_test")
    else
      connection = PG.connect(dbname: "makersbnb")
    end

    result = connection.exec_params("INSERT INTO rented_rooms (room_id, user_id, occupied_date) VALUES($1, $2, $3) RETURNING id, room_id, user_id, occupied_date;", [room_id, user_id, occupied_date])
    Rented_rooms.new(id: result[0]["id"], user_id: result[0]["user_id"], room_id: result[0]["room_id"], occupied_date: result[0]["occupied_date"])
  end
end
