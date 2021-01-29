require "application_system_test_case"

class ReferralsTest < ApplicationSystemTestCase
  setup do
    @referral = referrals(:one)
  end

  test "visiting the index" do
    visit referrals_url
    assert_selector "h1", text: "Referrals"
  end

  test "creating a Referral" do
    visit referrals_url
    click_on "New Referral"

    fill_in "Created on", with: @referral.created_on
    fill_in "Referred by", with: @referral.referred_by_id
    fill_in "User", with: @referral.user_id
    click_on "Create Referral"

    assert_text "Referral was successfully created"
    click_on "Back"
  end

  test "updating a Referral" do
    visit referrals_url
    click_on "Edit", match: :first

    fill_in "Created on", with: @referral.created_on
    fill_in "Referred by", with: @referral.referred_by_id
    fill_in "User", with: @referral.user_id
    click_on "Update Referral"

    assert_text "Referral was successfully updated"
    click_on "Back"
  end

  test "destroying a Referral" do
    visit referrals_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Referral was successfully destroyed"
  end
end
