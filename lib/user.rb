require "pg"
require_relative "../spec/database_helpers"

class User
  attr_reader :id, :name

  def initialize(id:, name:)
    @id = id
    @name = name
  end

  def self.add(name:, password:)
    connection = database_switcher
    result = connection.exec_params("INSERT INTO users (name, password) VALUES($1, $2) RETURNING id, name;", [name, password])
    User.new(id: result[0]["id"], name: result[0]["name"])
  end

  def self.signin(name:, password:)
    connection = database_switcher
    result = connection.query("SELECT id FROM users WHERE name = '#{name}';")
    if result.ntuples == 0
      nil
    else
      result[0]["id"]
    end
  end
end
