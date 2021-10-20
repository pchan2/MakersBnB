class Rented_rooms
  attr_reader :id, :room_id, :user_id, :occupied_date, :approved

  def initialize(id:, room_id:, user_id:, occupied_date:, approved:)
    @id = id
    @room_id = room_id
    @user_id = user_id
    @occupied_date = occupied_date
    @approved = (approved == 't')
  end

  def self.request_room(user_id:, room_id:, occupied_date:)
    approved = false
    if ENV["RACK_ENV"] == "test"
      connection = PG.connect(dbname: "makersbnb_test")
    else
      connection = PG.connect(dbname: "makersbnb")
    end

    result = connection.exec_params("INSERT INTO rented_rooms (room_id, user_id, occupied_date, approved) VALUES($1, $2, $3, $4) RETURNING id, room_id, user_id, occupied_date, approved;", [room_id, user_id, occupied_date, approved])
    Rented_rooms.new(id: result[0]["id"], user_id: result[0]["user_id"], room_id: result[0]["room_id"], occupied_date: result[0]["occupied_date"], approved: result[0]["approved"])
  end

  def approve_request(approval)
    @approved = true
    if ENV["RACK_ENV"] == "test"
      connection = PG.connect(dbname: "makersbnb_test")
    else
      connection = PG.connect(dbname: "makersbnb")
    end

    if approval
      connection.exec("UPDATE rented_rooms SET approved = #{true} WHERE id = #{@id}")
    else
      connection.exec("DELETE FROM rented_rooms WHERE id = #{@id}")
    end

  end
end
