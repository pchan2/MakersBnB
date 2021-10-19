require 'pg'

class User
  attr_reader :id,:name
  def initialize(id: , name:)
    @id = id
    @name = name
  end

  def self.add(name:)
    if ENV['RACK_ENV'] == 'test'
      connection = PG.connect(dbname: 'makersbnb_test')
    else
      connection = PG.connect(dbname: 'makersbnb')
    end
    result = connection.exec_params("INSERT INTO users (name) VALUES($1) RETURNING id, name;", [name])
    User.new(id: result[0]['id'], name: result[0]['name'])
  end
end
