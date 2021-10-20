require 'web_helpers'

feature "sign in" do
  scenario "User signs in" do
    signin

    persisted_data = PG.connect(dbname: 'makersbnb_test').query("SELECT * FROM users WHERE name='parsle';")
    expect(persisted_data[0]['name']).to eq 'parsle'
    expect(page).to have_current_path('/rooms')
  end
end
