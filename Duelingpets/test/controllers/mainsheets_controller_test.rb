require 'test_helper'

class MainsheetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @mainsheet = mainsheets(:one)
  end

  test "should get index" do
    get mainsheets_url
    assert_response :success
  end

  test "should get new" do
    get new_mainsheet_url
    assert_response :success
  end

  test "should create mainsheet" do
    assert_difference('Mainsheet.count') do
      post mainsheets_url, params: { mainsheet: { created_on: @mainsheet.created_on, description: @mainsheet.description, jukebox_id: @mainsheet.jukebox_id, title: @mainsheet.title, updated_on: @mainsheet.updated_on, user_id: @mainsheet.user_id } }
    end

    assert_redirected_to mainsheet_url(Mainsheet.last)
  end

  test "should show mainsheet" do
    get mainsheet_url(@mainsheet)
    assert_response :success
  end

  test "should get edit" do
    get edit_mainsheet_url(@mainsheet)
    assert_response :success
  end

  test "should update mainsheet" do
    patch mainsheet_url(@mainsheet), params: { mainsheet: { created_on: @mainsheet.created_on, description: @mainsheet.description, jukebox_id: @mainsheet.jukebox_id, title: @mainsheet.title, updated_on: @mainsheet.updated_on, user_id: @mainsheet.user_id } }
    assert_redirected_to mainsheet_url(@mainsheet)
  end

  test "should destroy mainsheet" do
    assert_difference('Mainsheet.count', -1) do
      delete mainsheet_url(@mainsheet)
    end

    assert_redirected_to mainsheets_url
  end
end
