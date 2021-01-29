require 'test_helper'

class GameinfosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @gameinfo = gameinfos(:one)
  end

  test "should get index" do
    get gameinfos_url
    assert_response :success
  end

  test "should get new" do
    get new_gameinfo_url
    assert_response :success
  end

  test "should create gameinfo" do
    assert_difference('Gameinfo.count') do
      post gameinfos_url, params: { gameinfo: { activated_on: @gameinfo.activated_on, ageing_enabled: @gameinfo.ageing_enabled, difficulty_id: @gameinfo.difficulty_id, failure: @gameinfo.failure, gamecompleted: @gameinfo.gamecompleted, lives_enabled: @gameinfo.lives_enabled, startgame: @gameinfo.startgame, success: @gameinfo.success } }
    end

    assert_redirected_to gameinfo_url(Gameinfo.last)
  end

  test "should show gameinfo" do
    get gameinfo_url(@gameinfo)
    assert_response :success
  end

  test "should get edit" do
    get edit_gameinfo_url(@gameinfo)
    assert_response :success
  end

  test "should update gameinfo" do
    patch gameinfo_url(@gameinfo), params: { gameinfo: { activated_on: @gameinfo.activated_on, ageing_enabled: @gameinfo.ageing_enabled, difficulty_id: @gameinfo.difficulty_id, failure: @gameinfo.failure, gamecompleted: @gameinfo.gamecompleted, lives_enabled: @gameinfo.lives_enabled, startgame: @gameinfo.startgame, success: @gameinfo.success } }
    assert_redirected_to gameinfo_url(@gameinfo)
  end

  test "should destroy gameinfo" do
    assert_difference('Gameinfo.count', -1) do
      delete gameinfo_url(@gameinfo)
    end

    assert_redirected_to gameinfos_url
  end
end
