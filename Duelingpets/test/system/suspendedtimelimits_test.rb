require "application_system_test_case"

class SuspendedtimelimitsTest < ApplicationSystemTestCase
  setup do
    @suspendedtimelimit = suspendedtimelimits(:one)
  end

  test "visiting the index" do
    visit suspendedtimelimits_url
    assert_selector "h1", text: "Suspendedtimelimits"
  end

  test "creating a Suspendedtimelimit" do
    visit suspendedtimelimits_url
    click_on "New Suspendedtimelimit"

    fill_in "Created on", with: @suspendedtimelimit.created_on
    fill_in "Emeraldfines", with: @suspendedtimelimit.emeraldfines
    fill_in "From user", with: @suspendedtimelimit.from_user_id
    fill_in "Pointfines", with: @suspendedtimelimit.pointfines
    fill_in "Reason", with: @suspendedtimelimit.reason
    fill_in "Timelimit", with: @suspendedtimelimit.timelimit
    fill_in "User", with: @suspendedtimelimit.user_id
    click_on "Create Suspendedtimelimit"

    assert_text "Suspendedtimelimit was successfully created"
    click_on "Back"
  end

  test "updating a Suspendedtimelimit" do
    visit suspendedtimelimits_url
    click_on "Edit", match: :first

    fill_in "Created on", with: @suspendedtimelimit.created_on
    fill_in "Emeraldfines", with: @suspendedtimelimit.emeraldfines
    fill_in "From user", with: @suspendedtimelimit.from_user_id
    fill_in "Pointfines", with: @suspendedtimelimit.pointfines
    fill_in "Reason", with: @suspendedtimelimit.reason
    fill_in "Timelimit", with: @suspendedtimelimit.timelimit
    fill_in "User", with: @suspendedtimelimit.user_id
    click_on "Update Suspendedtimelimit"

    assert_text "Suspendedtimelimit was successfully updated"
    click_on "Back"
  end

  test "destroying a Suspendedtimelimit" do
    visit suspendedtimelimits_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Suspendedtimelimit was successfully destroyed"
  end
end
