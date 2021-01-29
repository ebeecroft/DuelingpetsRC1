require "application_system_test_case"

class PouchesTest < ApplicationSystemTestCase
  setup do
    @pouch = pouches(:one)
  end

  test "visiting the index" do
    visit pouches_url
    assert_selector "h1", text: "Pouches"
  end

  test "creating a Pouch" do
    visit pouches_url
    click_on "New Pouch"

    check "Activated" if @pouch.activated
    check "Admin" if @pouch.admin
    fill_in "Amount", with: @pouch.amount
    check "Banned" if @pouch.banned
    fill_in "Bloglevel", with: @pouch.bloglevel
    check "Demouser" if @pouch.demouser
    fill_in "Dreyterriumamount", with: @pouch.dreyterriumamount
    fill_in "Dreyterriumlevel", with: @pouch.dreyterriumlevel
    fill_in "Emeraldamount", with: @pouch.emeraldamount
    fill_in "Emeraldlevel", with: @pouch.emeraldlevel
    fill_in "Expiretime", with: @pouch.expiretime
    check "Firstdreyterrium" if @pouch.firstdreyterrium
    check "Gone" if @pouch.gone
    fill_in "Last visited", with: @pouch.last_visited
    fill_in "Pouchlevel", with: @pouch.pouchlevel
    fill_in "Privilege", with: @pouch.privilege
    fill_in "Remember token", with: @pouch.remember_token
    fill_in "Signed in at", with: @pouch.signed_in_at
    fill_in "Signed out at", with: @pouch.signed_out_at
    fill_in "User", with: @pouch.user_id
    click_on "Create Pouch"

    assert_text "Pouch was successfully created"
    click_on "Back"
  end

  test "updating a Pouch" do
    visit pouches_url
    click_on "Edit", match: :first

    check "Activated" if @pouch.activated
    check "Admin" if @pouch.admin
    fill_in "Amount", with: @pouch.amount
    check "Banned" if @pouch.banned
    fill_in "Bloglevel", with: @pouch.bloglevel
    check "Demouser" if @pouch.demouser
    fill_in "Dreyterriumamount", with: @pouch.dreyterriumamount
    fill_in "Dreyterriumlevel", with: @pouch.dreyterriumlevel
    fill_in "Emeraldamount", with: @pouch.emeraldamount
    fill_in "Emeraldlevel", with: @pouch.emeraldlevel
    fill_in "Expiretime", with: @pouch.expiretime
    check "Firstdreyterrium" if @pouch.firstdreyterrium
    check "Gone" if @pouch.gone
    fill_in "Last visited", with: @pouch.last_visited
    fill_in "Pouchlevel", with: @pouch.pouchlevel
    fill_in "Privilege", with: @pouch.privilege
    fill_in "Remember token", with: @pouch.remember_token
    fill_in "Signed in at", with: @pouch.signed_in_at
    fill_in "Signed out at", with: @pouch.signed_out_at
    fill_in "User", with: @pouch.user_id
    click_on "Update Pouch"

    assert_text "Pouch was successfully updated"
    click_on "Back"
  end

  test "destroying a Pouch" do
    visit pouches_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Pouch was successfully destroyed"
  end
end
