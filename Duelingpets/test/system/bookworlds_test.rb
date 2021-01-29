require "application_system_test_case"

class BookworldsTest < ApplicationSystemTestCase
  setup do
    @bookworld = bookworlds(:one)
  end

  test "visiting the index" do
    visit bookworlds_url
    assert_selector "h1", text: "Bookworlds"
  end

  test "creating a Bookworld" do
    visit bookworlds_url
    click_on "New Bookworld"

    fill_in "Created on", with: @bookworld.created_on
    fill_in "Description", with: @bookworld.description
    fill_in "Name", with: @bookworld.name
    check "Open world" if @bookworld.open_world
    fill_in "Price", with: @bookworld.price
    check "Privateworld" if @bookworld.privateworld
    fill_in "Updated on", with: @bookworld.updated_on
    fill_in "User", with: @bookworld.user_id
    click_on "Create Bookworld"

    assert_text "Bookworld was successfully created"
    click_on "Back"
  end

  test "updating a Bookworld" do
    visit bookworlds_url
    click_on "Edit", match: :first

    fill_in "Created on", with: @bookworld.created_on
    fill_in "Description", with: @bookworld.description
    fill_in "Name", with: @bookworld.name
    check "Open world" if @bookworld.open_world
    fill_in "Price", with: @bookworld.price
    check "Privateworld" if @bookworld.privateworld
    fill_in "Updated on", with: @bookworld.updated_on
    fill_in "User", with: @bookworld.user_id
    click_on "Update Bookworld"

    assert_text "Bookworld was successfully updated"
    click_on "Back"
  end

  test "destroying a Bookworld" do
    visit bookworlds_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Bookworld was successfully destroyed"
  end
end
