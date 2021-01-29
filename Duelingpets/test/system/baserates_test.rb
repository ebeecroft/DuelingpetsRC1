require "application_system_test_case"

class BaseratesTest < ApplicationSystemTestCase
  setup do
    @baserate = baserates(:one)
  end

  test "visiting the index" do
    visit baserates_url
    assert_selector "h1", text: "Baserates"
  end

  test "creating a Baserate" do
    visit baserates_url
    click_on "New Baserate"

    fill_in "Amount", with: @baserate.amount
    fill_in "Created on", with: @baserate.created_on
    fill_in "Name", with: @baserate.name
    click_on "Create Baserate"

    assert_text "Baserate was successfully created"
    click_on "Back"
  end

  test "updating a Baserate" do
    visit baserates_url
    click_on "Edit", match: :first

    fill_in "Amount", with: @baserate.amount
    fill_in "Created on", with: @baserate.created_on
    fill_in "Name", with: @baserate.name
    click_on "Update Baserate"

    assert_text "Baserate was successfully updated"
    click_on "Back"
  end

  test "destroying a Baserate" do
    visit baserates_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Baserate was successfully destroyed"
  end
end
