require "room"

describe '.add' do
  it 'adds rooms to database' do
    room = Room.add(user_id: 2, title: 'castle', description: 'a victorian folley', price: 80, location: 'Scotland' )
    persisted_data = PG.connect(dbname: 'makersbnb_test').query("SELECT * FROM rooms WHERE id = #{room.id};")

    expect(room).to be_a Room
    expect(room.id).to eq persisted_data.first['id']
    expect(room.title).to eq "castle"
    expect(room.description).to eq "a victorian folley"
    expect(room.price).to eq '$80.00'
    expect(room.location).to eq "Scotland"
  end
end
