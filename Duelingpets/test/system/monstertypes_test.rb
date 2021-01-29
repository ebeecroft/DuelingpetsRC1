require "application_system_test_case"

class MonstertypesTest < ApplicationSystemTestCase
  setup do
    @monstertype = monstertypes(:one)
  end

  test "visiting the index" do
    visit monstertypes_url
    assert_selector "h1", text: "Monstertypes"
  end

  test "creating a Monstertype" do
    visit monstertypes_url
    click_on "New Monstertype"

    fill_in "Basecost", with: @monstertype.basecost
    fill_in "Created on", with: @monstertype.created_on
    fill_in "Name", with: @monstertype.name
    click_on "Create Monstertype"

    assert_text "Monstertype was successfully created"
    click_on "Back"
  end

  test "updating a Monstertype" do
    visit monstertypes_url
    click_on "Edit", match: :first

    fill_in "Basecost", with: @monstertype.basecost
    fill_in "Created on", with: @monstertype.created_on
    fill_in "Name", with: @monstertype.name
    click_on "Update Monstertype"

    assert_text "Monstertype was successfully updated"
    click_on "Back"
  end

  test "destroying a Monstertype" do
    visit monstertypes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Monstertype was successfully destroyed"
  end
end
