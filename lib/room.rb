require 'pg'
class Room

  attr_reader :id, :user_id, :title, :description, :price, :location, :available_from, :available_to

  def initialize(id:, user_id:, title:, description:, price:, location:, available_from:, available_to:)
    @id = id
    @user_id = user_id
    @title = title
    @description = description
    @price = price
    @location = location
    @available_from = available_from
    @available_to = available_to
  end

  def self.add(user_id:, title:, description:, price:, location:, available_from: "2020-12-10", available_to: "2022-01-01")

    connection = database_switcher

    result = connection.exec_params(
      "INSERT INTO rooms (user_id, title, description, price, location, available_from, available_to)
      VALUES($1, $2, $3, $4, $5, $6, $7)
      RETURNING id, user_id, title, description, price, location, available_from, available_to;",
      [user_id, title, description, price, location, available_from, available_to])

    Room.new(
      id: result[0]['id'],
      user_id: result[0]['user_id'],
      title: result[0]['title'],
      description: result[0]['description'],
      price: result[0]['price'],
      location: result[0]['location'],
      available_from: result[0]["available_from"],
      available_to: result[0]["available_to"])
  end

  def self.all
    connection = database_switcher

    result = connection.exec("SELECT * FROM rooms")
    result.map do |room|
      Room.new(
        id: room['id'],
        user_id: room['user_id'],
        title: room['title'],
        description: room['description'],
        price: room['price'],
        location: room['location'],
        available_from: room['available_from'],
        available_to: room['available_to']
      )
    end
  end

  def self.available_rooms(request_date)

    connection = database_switcher

    available_rooms = connection.exec(
        "SELECT * FROM rooms
        WHERE available_from <= '#{request_date}'
          AND available_to >= '#{request_date}';"
      )

      available_rooms.map do |room|
        Room.new(
          id: room['id'],
          user_id: room['user_id'],
          title: room['title'],
          description: room['description'],
          price: room['price'],
          location: room['location'],
          available_from: room['available_from'],
          available_to: room['available_to']
      )
    end
  end
end
