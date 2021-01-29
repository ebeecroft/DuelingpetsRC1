require 'test_helper'

class BlogrepliesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @blogreply = blogreplies(:one)
  end

  test "should get index" do
    get blogreplies_url
    assert_response :success
  end

  test "should get new" do
    get new_blogreply_url
    assert_response :success
  end

  test "should create blogreply" do
    assert_difference('Blogreply.count') do
      post blogreplies_url, params: { blogreply: { blog_id: @blogreply.blog_id, created_on: @blogreply.created_on, message: @blogreply.message, reviewed: @blogreply.reviewed, reviewed_on: @blogreply.reviewed_on, updated_on: @blogreply.updated_on, user_id: @blogreply.user_id } }
    end

    assert_redirected_to blogreply_url(Blogreply.last)
  end

  test "should show blogreply" do
    get blogreply_url(@blogreply)
    assert_response :success
  end

  test "should get edit" do
    get edit_blogreply_url(@blogreply)
    assert_response :success
  end

  test "should update blogreply" do
    patch blogreply_url(@blogreply), params: { blogreply: { blog_id: @blogreply.blog_id, created_on: @blogreply.created_on, message: @blogreply.message, reviewed: @blogreply.reviewed, reviewed_on: @blogreply.reviewed_on, updated_on: @blogreply.updated_on, user_id: @blogreply.user_id } }
    assert_redirected_to blogreply_url(@blogreply)
  end

  test "should destroy blogreply" do
    assert_difference('Blogreply.count', -1) do
      delete blogreply_url(@blogreply)
    end

    assert_redirected_to blogreplies_url
  end
end
