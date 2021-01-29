require 'test_helper'

class MainfoldersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @mainfolder = mainfolders(:one)
  end

  test "should get index" do
    get mainfolders_url
    assert_response :success
  end

  test "should get new" do
    get new_mainfolder_url
    assert_response :success
  end

  test "should create mainfolder" do
    assert_difference('Mainfolder.count') do
      post mainfolders_url, params: { mainfolder: { created_on: @mainfolder.created_on, description: @mainfolder.description, gallery_id: @mainfolder.gallery_id, title: @mainfolder.title, updated_on: @mainfolder.updated_on, user_id: @mainfolder.user_id } }
    end

    assert_redirected_to mainfolder_url(Mainfolder.last)
  end

  test "should show mainfolder" do
    get mainfolder_url(@mainfolder)
    assert_response :success
  end

  test "should get edit" do
    get edit_mainfolder_url(@mainfolder)
    assert_response :success
  end

  test "should update mainfolder" do
    patch mainfolder_url(@mainfolder), params: { mainfolder: { created_on: @mainfolder.created_on, description: @mainfolder.description, gallery_id: @mainfolder.gallery_id, title: @mainfolder.title, updated_on: @mainfolder.updated_on, user_id: @mainfolder.user_id } }
    assert_redirected_to mainfolder_url(@mainfolder)
  end

  test "should destroy mainfolder" do
    assert_difference('Mainfolder.count', -1) do
      delete mainfolder_url(@mainfolder)
    end

    assert_redirected_to mainfolders_url
  end
end
