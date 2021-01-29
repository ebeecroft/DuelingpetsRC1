require "application_system_test_case"

class BlacklisteddomainsTest < ApplicationSystemTestCase
  setup do
    @blacklisteddomain = blacklisteddomains(:one)
  end

  test "visiting the index" do
    visit blacklisteddomains_url
    assert_selector "h1", text: "Blacklisteddomains"
  end

  test "creating a Blacklisteddomain" do
    visit blacklisteddomains_url
    click_on "New Blacklisteddomain"

    fill_in "Created on", with: @blacklisteddomain.created_on
    check "Domain only" if @blacklisteddomain.domain_only
    fill_in "Name", with: @blacklisteddomain.name
    click_on "Create Blacklisteddomain"

    assert_text "Blacklisteddomain was successfully created"
    click_on "Back"
  end

  test "updating a Blacklisteddomain" do
    visit blacklisteddomains_url
    click_on "Edit", match: :first

    fill_in "Created on", with: @blacklisteddomain.created_on
    check "Domain only" if @blacklisteddomain.domain_only
    fill_in "Name", with: @blacklisteddomain.name
    click_on "Update Blacklisteddomain"

    assert_text "Blacklisteddomain was successfully updated"
    click_on "Back"
  end

  test "destroying a Blacklisteddomain" do
    visit blacklisteddomains_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Blacklisteddomain was successfully destroyed"
  end
end
