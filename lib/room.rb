require 'pg'

class Room

  attr_reader :id, :user_id, :title, :description, :price, :location

  def initialize(id:, user_id:, title:, description:, price:, location:)
    @id = id
    @user_id = user_id
    @title = title
    @description = description
    @price = price
    @location = location
  end

  def self.add(user_id:, title:, description:, price:, location:)
    if ENV['RACK_ENV'] == 'test'
      connection = PG.connect(dbname: 'makersbnb_test')
    else
      connection = PG.connect(dbname: 'makersbnb')
    end
    result = connection.exec_params("INSERT INTO rooms (user_id, title, description, price, location) VALUES($1, $2, $3, $4, $5) RETURNING id, user_id, title, description, price, location;", [user_id, title, description, price, location])
    Room.new(id: result[0]['id'], user_id: result[0]['user_id'], title: result[0]['title'], description: result[0]['description'], price: result[0]['price'], location: result[0]['location'])
  end
end
