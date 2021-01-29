require 'test_helper'

class SubfoldersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @subfolder = subfolders(:one)
  end

  test "should get index" do
    get subfolders_url
    assert_response :success
  end

  test "should get new" do
    get new_subfolder_url
    assert_response :success
  end

  test "should create subfolder" do
    assert_difference('Subfolder.count') do
      post subfolders_url, params: { subfolder: { collab_mode: @subfolder.collab_mode, created_on: @subfolder.created_on, description: @subfolder.description, fave_folder: @subfolder.fave_folder, mainfolder_id: @subfolder.mainfolder_id, privatesubfolder: @subfolder.privatesubfolder, title: @subfolder.title, updated_on: @subfolder.updated_on, user_id: @subfolder.user_id } }
    end

    assert_redirected_to subfolder_url(Subfolder.last)
  end

  test "should show subfolder" do
    get subfolder_url(@subfolder)
    assert_response :success
  end

  test "should get edit" do
    get edit_subfolder_url(@subfolder)
    assert_response :success
  end

  test "should update subfolder" do
    patch subfolder_url(@subfolder), params: { subfolder: { collab_mode: @subfolder.collab_mode, created_on: @subfolder.created_on, description: @subfolder.description, fave_folder: @subfolder.fave_folder, mainfolder_id: @subfolder.mainfolder_id, privatesubfolder: @subfolder.privatesubfolder, title: @subfolder.title, updated_on: @subfolder.updated_on, user_id: @subfolder.user_id } }
    assert_redirected_to subfolder_url(@subfolder)
  end

  test "should destroy subfolder" do
    assert_difference('Subfolder.count', -1) do
      delete subfolder_url(@subfolder)
    end

    assert_redirected_to subfolders_url
  end
end
