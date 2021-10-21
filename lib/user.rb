require "pg"
require_relative "../spec/database_helpers"
require "BCrypt"

class User
  attr_reader :id, :name

  def initialize(id:, name:)
    @id = id
    @name = name
  end

  def self.add(name:, password:)
    connection = database_switcher
    encrypted_password = BCrypt::Password.create(password)
    result = connection.exec_params("INSERT INTO users (name, password) VALUES($1, $2) RETURNING id, name;", [name, encrypted_password])
    User.new(id: result[0]["id"], name: result[0]["name"])
  end

  def self.signin(name:, password:)
    connection = database_switcher
    result = connection.query("SELECT * FROM users WHERE name = '#{name}';")

    return nil if result.ntuples == 0

    if BCrypt::Password.new(result[0]['password']) == password
      result[0]["id"]
    else
      nil
    end
  end
end
