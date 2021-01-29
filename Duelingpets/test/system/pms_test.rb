require "application_system_test_case"

class PmsTest < ApplicationSystemTestCase
  setup do
    @pm = pms(:one)
  end

  test "visiting the index" do
    visit pms_url
    assert_selector "h1", text: "Pms"
  end

  test "creating a Pm" do
    visit pms_url
    click_on "New Pm"

    fill_in "Created on", with: @pm.created_on
    fill_in "Message", with: @pm.message
    fill_in "Pmbox", with: @pm.pmbox_id
    fill_in "Title", with: @pm.title
    check "User1 unread" if @pm.user1_unread
    check "User2 unread" if @pm.user2_unread
    fill_in "User", with: @pm.user_id
    click_on "Create Pm"

    assert_text "Pm was successfully created"
    click_on "Back"
  end

  test "updating a Pm" do
    visit pms_url
    click_on "Edit", match: :first

    fill_in "Created on", with: @pm.created_on
    fill_in "Message", with: @pm.message
    fill_in "Pmbox", with: @pm.pmbox_id
    fill_in "Title", with: @pm.title
    check "User1 unread" if @pm.user1_unread
    check "User2 unread" if @pm.user2_unread
    fill_in "User", with: @pm.user_id
    click_on "Update Pm"

    assert_text "Pm was successfully updated"
    click_on "Back"
  end

  test "destroying a Pm" do
    visit pms_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Pm was successfully destroyed"
  end
end
