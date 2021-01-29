require "application_system_test_case"

class UserinfosTest < ApplicationSystemTestCase
  setup do
    @userinfo = userinfos(:one)
  end

  test "visiting the index" do
    visit userinfos_url
    assert_selector "h1", text: "Userinfos"
  end

  test "creating a Userinfo" do
    visit userinfos_url
    click_on "New Userinfo"

    check "Admincontrols on" if @userinfo.admincontrols_on
    fill_in "Audiobrowser", with: @userinfo.audiobrowser
    fill_in "Avatar", with: @userinfo.avatar
    fill_in "Bookgroup", with: @userinfo.bookgroup_id
    fill_in "Daycolor", with: @userinfo.daycolor_id
    fill_in "Info", with: @userinfo.info
    check "Keymastercontrols on" if @userinfo.keymastercontrols_on
    check "Managercontrols on" if @userinfo.managercontrols_on
    check "Militarytime" if @userinfo.militarytime
    fill_in "Miniavatar", with: @userinfo.miniavatar
    fill_in "Mp3", with: @userinfo.mp3
    check "Music on" if @userinfo.music_on
    check "Mute on" if @userinfo.mute_on
    fill_in "Nightcolor", with: @userinfo.nightcolor_id
    fill_in "Ogg", with: @userinfo.ogg
    check "Reviewercontrols on" if @userinfo.reviewercontrols_on
    fill_in "User", with: @userinfo.user_id
    fill_in "Videobrowser", with: @userinfo.videobrowser
    click_on "Create Userinfo"

    assert_text "Userinfo was successfully created"
    click_on "Back"
  end

  test "updating a Userinfo" do
    visit userinfos_url
    click_on "Edit", match: :first

    check "Admincontrols on" if @userinfo.admincontrols_on
    fill_in "Audiobrowser", with: @userinfo.audiobrowser
    fill_in "Avatar", with: @userinfo.avatar
    fill_in "Bookgroup", with: @userinfo.bookgroup_id
    fill_in "Daycolor", with: @userinfo.daycolor_id
    fill_in "Info", with: @userinfo.info
    check "Keymastercontrols on" if @userinfo.keymastercontrols_on
    check "Managercontrols on" if @userinfo.managercontrols_on
    check "Militarytime" if @userinfo.militarytime
    fill_in "Miniavatar", with: @userinfo.miniavatar
    fill_in "Mp3", with: @userinfo.mp3
    check "Music on" if @userinfo.music_on
    check "Mute on" if @userinfo.mute_on
    fill_in "Nightcolor", with: @userinfo.nightcolor_id
    fill_in "Ogg", with: @userinfo.ogg
    check "Reviewercontrols on" if @userinfo.reviewercontrols_on
    fill_in "User", with: @userinfo.user_id
    fill_in "Videobrowser", with: @userinfo.videobrowser
    click_on "Update Userinfo"

    assert_text "Userinfo was successfully updated"
    click_on "Back"
  end

  test "destroying a Userinfo" do
    visit userinfos_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Userinfo was successfully destroyed"
  end
end
