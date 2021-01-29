require "application_system_test_case"

class RegtokensTest < ApplicationSystemTestCase
  setup do
    @regtoken = regtokens(:one)
  end

  test "visiting the index" do
    visit regtokens_url
    assert_selector "h1", text: "Regtokens"
  end

  test "creating a Regtoken" do
    visit regtokens_url
    click_on "New Regtoken"

    fill_in "Expiretime", with: @regtoken.expiretime
    fill_in "Token", with: @regtoken.token
    click_on "Create Regtoken"

    assert_text "Regtoken was successfully created"
    click_on "Back"
  end

  test "updating a Regtoken" do
    visit regtokens_url
    click_on "Edit", match: :first

    fill_in "Expiretime", with: @regtoken.expiretime
    fill_in "Token", with: @regtoken.token
    click_on "Update Regtoken"

    assert_text "Regtoken was successfully updated"
    click_on "Back"
  end

  test "destroying a Regtoken" do
    visit regtokens_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Regtoken was successfully destroyed"
  end
end
