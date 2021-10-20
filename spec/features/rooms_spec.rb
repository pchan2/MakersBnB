require 'web_helpers'

feature "Welcome" do
  scenario "user sees their name" do
    signin
    
    expect(page).to have_content 'Welcome parsle'
  end
end

feature "create room" do
  scenario "user creates a room" do
    signin
    visit '/rooms/new'
    fill_in('title', with: 'Warwick Castle')
    fill_in('description', with: 'a victorian cottage')
    fill_in('price', with: 100)
    fill_in('location', with: 'Wales')
    click_button 'Create'
    
    expect(page).to have_content 'Warwick Castle'
    expect(page).to have_content 'a victorian cottage'
    expect(page).to have_content '$100.00'
    expect(page).to have_content 'Wales'
  end
end

# feature "list new space" do
#   scenario "user sees a list of spaces" do
#     signin
    
#     expect(page).to have_content 'Warwick Castle'
#     expect(page).to have_content 'a victorian cottage'
#     expect(page).to have_content '$100.00'
#     expect(page).to have_content 'Wales'
#   end
# end