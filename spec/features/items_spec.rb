require 'rails_helper'

RSpec.feature "Items", type: :feature do
  scenario "Admin adds an item" do
    user = FactoryGirl.create(:user, admin: true)
    visit root_path(as: user)

    # Compare to ...
    # visit root_path
    # click_link "Sign in"
    # fill_in "Email", with: user.email
    # fill_in "Password", with: "password"
    # click_button "Sign in"

    click_link "Items"
    click_link "New Item"

    expect {
      fill_in "Name", with: "Steel Sprocket"
      fill_in "Description", with: "The finest sprocket available!"
      fill_in "Price", with: "299"
      click_button "Create Item"
    }.to change(Item, :count).by(1)

    expect(page).to have_content "Item was successfully created"
  end

  scenario "User views an item" do
    user = FactoryGirl.create(:user)
    item = FactoryGirl.create(:item, name: "Radical Rotor")

    visit root_path(as: user)
    click_link "Show"

    expect(current_path).to eq item_path(item)
    expect(page).to have_content "Radical Rotor"
    expect(page).to_not have_link "Edit"
    expect(page).to_not have_link "Destroy"
  end
end
