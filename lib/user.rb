require 'pg'

class User
  
  attr_reader :id,:name

  def initialize(id: , name:)
    @id = id
    @name = name
  end

  def self.add(name:)
    connection = database_switcher

    result = connection.exec_params("INSERT INTO users (name) VALUES($1) RETURNING id, name;", [name])
    User.new(id: result[0]['id'], name: result[0]['name'])
  end
end
