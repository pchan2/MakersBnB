require "user"

describe User do
  describe "#.add" do
    it "adds users to database" do
      user = User.add(name: "Bob")
      persisted_data = PG.connect(dbname: "makersbnb_test").query("SELECT * FROM users WHERE id = #{user.id};")

      expect(user).to be_a User
      expect(user.id).to eq persisted_data.first["id"]
      expect(user.name).to eq "Bob"
    end
  end

  describe "#.signin" do
    it "recognise an existing user" do
      expect(User.signin(name: "Dave")).to eq "1"
    end
  end
end
