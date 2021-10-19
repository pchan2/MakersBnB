require "pg"

def setup_test_database
  p "Setting up test database..."

  connection = PG.connect(dbname: "makersbnb_test")

  # Clear the bookmarks table
  connection.exec("TRUNCATE rented_rooms, rooms, users")


end
