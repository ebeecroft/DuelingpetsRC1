require 'test_helper'

class UserinfosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @userinfo = userinfos(:one)
  end

  test "should get index" do
    get userinfos_url
    assert_response :success
  end

  test "should get new" do
    get new_userinfo_url
    assert_response :success
  end

  test "should create userinfo" do
    assert_difference('Userinfo.count') do
      post userinfos_url, params: { userinfo: { admincontrols_on: @userinfo.admincontrols_on, audiobrowser: @userinfo.audiobrowser, avatar: @userinfo.avatar, bookgroup_id: @userinfo.bookgroup_id, daycolor_id: @userinfo.daycolor_id, info: @userinfo.info, keymastercontrols_on: @userinfo.keymastercontrols_on, managercontrols_on: @userinfo.managercontrols_on, militarytime: @userinfo.militarytime, miniavatar: @userinfo.miniavatar, mp3: @userinfo.mp3, music_on: @userinfo.music_on, mute_on: @userinfo.mute_on, nightcolor_id: @userinfo.nightcolor_id, ogg: @userinfo.ogg, reviewercontrols_on: @userinfo.reviewercontrols_on, user_id: @userinfo.user_id, videobrowser: @userinfo.videobrowser } }
    end

    assert_redirected_to userinfo_url(Userinfo.last)
  end

  test "should show userinfo" do
    get userinfo_url(@userinfo)
    assert_response :success
  end

  test "should get edit" do
    get edit_userinfo_url(@userinfo)
    assert_response :success
  end

  test "should update userinfo" do
    patch userinfo_url(@userinfo), params: { userinfo: { admincontrols_on: @userinfo.admincontrols_on, audiobrowser: @userinfo.audiobrowser, avatar: @userinfo.avatar, bookgroup_id: @userinfo.bookgroup_id, daycolor_id: @userinfo.daycolor_id, info: @userinfo.info, keymastercontrols_on: @userinfo.keymastercontrols_on, managercontrols_on: @userinfo.managercontrols_on, militarytime: @userinfo.militarytime, miniavatar: @userinfo.miniavatar, mp3: @userinfo.mp3, music_on: @userinfo.music_on, mute_on: @userinfo.mute_on, nightcolor_id: @userinfo.nightcolor_id, ogg: @userinfo.ogg, reviewercontrols_on: @userinfo.reviewercontrols_on, user_id: @userinfo.user_id, videobrowser: @userinfo.videobrowser } }
    assert_redirected_to userinfo_url(@userinfo)
  end

  test "should destroy userinfo" do
    assert_difference('Userinfo.count', -1) do
      delete userinfo_url(@userinfo)
    end

    assert_redirected_to userinfos_url
  end
end
