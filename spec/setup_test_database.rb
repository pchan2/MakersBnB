require "pg"

def setup_test_database

  connection = PG.connect(dbname: "makersbnb_test")

  # Clear the bookmarks table
  connection.exec("TRUNCATE rented_rooms, rooms, users")
  connection.exec("ALTER SEQUENCE users_id_seq RESTART WITH 1;")
  connection.exec("ALTER SEQUENCE rooms_id_seq RESTART WITH 1;")
  
  populate_users(connection)
  populate_rooms(connection)
  populate_rented_rooms(connection)
end

def populate_users(connection)
  #populating users
  connection.exec("INSERT INTO users(name) VALUES('Dave');")
  connection.exec("INSERT INTO users(name) VALUES('Susan');")
end

def populate_rooms(connection)


  connection.exec("INSERT INTO rooms(user_id, title, description, price, location)
    VALUES(2, 'castle', 'a victorian folley', 80, 'Scotland' );"
  )

  connection.exec("INSERT INTO rooms(user_id, title, description, price, location)
  VALUES(1, 'windmill', 'A really old windmill', 59.98, 'Essex');"
)
end

def populate_rented_rooms(connection)
  connection.exec("INSERT INTO rented_rooms(room_id, user_id, occupied_date, approved)
    VALUES(1, 1, '2001-10-19', FALSE);"
  )

  connection.exec("INSERT INTO rented_rooms(room_id, user_id, occupied_date, approved)
    VALUES(2, 2, '2021-12-25', TRUE);"
  )

end

