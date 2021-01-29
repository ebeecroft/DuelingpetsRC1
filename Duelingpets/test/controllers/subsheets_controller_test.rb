require 'test_helper'

class SubsheetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @subsheet = subsheets(:one)
  end

  test "should get index" do
    get subsheets_url
    assert_response :success
  end

  test "should get new" do
    get new_subsheet_url
    assert_response :success
  end

  test "should create subsheet" do
    assert_difference('Subsheet.count') do
      post subsheets_url, params: { subsheet: { collab_mode: @subsheet.collab_mode, created_on: @subsheet.created_on, description: @subsheet.description, fave_folder: @subsheet.fave_folder, mainsheet_id: @subsheet.mainsheet_id, privatesubsheet: @subsheet.privatesubsheet, title: @subsheet.title, updated_on: @subsheet.updated_on, user_id: @subsheet.user_id } }
    end

    assert_redirected_to subsheet_url(Subsheet.last)
  end

  test "should show subsheet" do
    get subsheet_url(@subsheet)
    assert_response :success
  end

  test "should get edit" do
    get edit_subsheet_url(@subsheet)
    assert_response :success
  end

  test "should update subsheet" do
    patch subsheet_url(@subsheet), params: { subsheet: { collab_mode: @subsheet.collab_mode, created_on: @subsheet.created_on, description: @subsheet.description, fave_folder: @subsheet.fave_folder, mainsheet_id: @subsheet.mainsheet_id, privatesubsheet: @subsheet.privatesubsheet, title: @subsheet.title, updated_on: @subsheet.updated_on, user_id: @subsheet.user_id } }
    assert_redirected_to subsheet_url(@subsheet)
  end

  test "should destroy subsheet" do
    assert_difference('Subsheet.count', -1) do
      delete subsheet_url(@subsheet)
    end

    assert_redirected_to subsheets_url
  end
end
