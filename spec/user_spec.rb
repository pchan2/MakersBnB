require "user"

describe '.add' do
  it 'adds users to database' do
    user = User.add(name: "Bob")
    persisted_data = PG.connect(dbname: 'makersbnb_test').query("SELECT * FROM users WHERE id = #{user.id};")

    expect(user).to be_a User
    expect(user.id).to eq persisted_data.first['id']
    expect(user.name).to eq "Bob"
  end
end