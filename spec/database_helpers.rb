def database_switcher
  if ENV["RACK_ENV"] == "test"
    connection = PG.connect(dbname: "makersbnb_test")
  else
    connection = PG.connect(dbname: "makersbnb")
  end
end
