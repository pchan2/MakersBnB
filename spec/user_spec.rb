require "user"

describe User do
  describe "#.add" do
    it "adds users to database" do
      user = User.add(name: "Bob", password: "12345678")
      persisted_data = PG.connect(dbname: "makersbnb_test").query("SELECT * FROM users WHERE id = #{user.id};")

      expect(user).to be_a User
      expect(user.id).to eq persisted_data.first["id"]
      expect(user.name).to eq "Bob"
      expect(persisted_data.first["password"]).to eq "12345678"
    end
  end

  describe "#.signin" do
    it "recognise an existing user" do
      expect(User.signin(name: "Dave", password: "12345678")).to eq "1"
    end
    it "wont recognise a user with wrong password" do
      expect(User.signin(name: "Dave", password: "wrongpword")).to eq nil
    end
  end
end
