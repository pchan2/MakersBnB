require "room"

describe '.add' do
  it 'adds rooms to database' do
    room = Room.add(user_id: 2, title: 'Warwick Castle', description: 'a victorian cottage', price: 100, location: 'Wales' )
    persisted_data = PG.connect(dbname: 'makersbnb_test').query("SELECT * FROM rooms WHERE id = #{room.id};")

    expect(room).to be_a Room
    expect(room.id).to eq persisted_data.first['id']
    expect(room.title).to eq "Warwick Castle"
    expect(room.description).to eq "a victorian cottage"
    expect(room.price).to eq '$100.00'
    expect(room.location).to eq "Wales"
  end
end

describe '.all' do
  it 'returns all rooms from the database' do
    room = Room.add(user_id: 2, title: 'Warwick Castle', description: 'a victorian cottage', price: 100, location: 'Wales' )

    expect(Room.all.last.id).to eq room.id #checks the lastest added room has the same id as the returned one.
  end
end
