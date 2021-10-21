require "room"
describe Room do
  describe '.add' do
    it 'adds rooms to database' do
      #todo- add available_from and available_to functionality to Room.add method
      room = Room.add(user_id: 2, title: 'Warwick Castle', description: 'a victorian cottage', price: 100, location: 'Wales', available_from: "2021-10-21", available_to:"2021-12-21")
      persisted_data = PG.connect(dbname: 'makersbnb_test').query("SELECT * FROM rooms WHERE id = #{room.id};")

      expect(room).to be_a Room
      expect(room.id).to eq persisted_data.first['id']
      expect(room.title).to eq "Warwick Castle"
      expect(room.description).to eq "a victorian cottage"
      expect(room.price).to eq '$100.00'
      expect(room.location).to eq "Wales"
      expect(room.available_from).to eq "2021-10-21"
      expect(room.available_to).to eq "2021-12-21"
    end
  end

  describe '.all' do
    it 'returns all rooms from the database' do
      room = Room.add(user_id: 2, title: 'Warwick Castle', description: 'a victorian cottage', price: 100, location: 'Wales' )

      expect(Room.all.last.id).to eq room.id #checks the lastest added room has the same id as the returned one.
    end

  end

  describe ".available_rooms" do
    it "filters available rooms" do
      room1 = Room.add(user_id:2, title: "Sunny's house", description: "a 4 bedroom house", price: 100, location: "Cornwall", available_from: "2021-10-21", available_to: "2021-12-25")
      room2 = Room.add(user_id:1, title: "Patrick's house", description: "a 1 bedroom house", price: 100, location: "Birmingham", available_from: "2022-10-21", available_to: "2022-10-25")
      request_date = '2021-10-22'
      return_rooms = Room.available_rooms(request_date)

      expect(return_rooms[0].title).to eq "Sunny's house"
      expect(return_rooms[0].title).to_not eq "Patrick's house"
    end
  end

end


