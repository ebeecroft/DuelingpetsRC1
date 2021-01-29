require 'test_helper'

class BlogtypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @blogtype = blogtypes(:one)
  end

  test "should get index" do
    get blogtypes_url
    assert_response :success
  end

  test "should get new" do
    get new_blogtype_url
    assert_response :success
  end

  test "should create blogtype" do
    assert_difference('Blogtype.count') do
      post blogtypes_url, params: { blogtype: { created_on: @blogtype.created_on, name: @blogtype.name } }
    end

    assert_redirected_to blogtype_url(Blogtype.last)
  end

  test "should show blogtype" do
    get blogtype_url(@blogtype)
    assert_response :success
  end

  test "should get edit" do
    get edit_blogtype_url(@blogtype)
    assert_response :success
  end

  test "should update blogtype" do
    patch blogtype_url(@blogtype), params: { blogtype: { created_on: @blogtype.created_on, name: @blogtype.name } }
    assert_redirected_to blogtype_url(@blogtype)
  end

  test "should destroy blogtype" do
    assert_difference('Blogtype.count', -1) do
      delete blogtype_url(@blogtype)
    end

    assert_redirected_to blogtypes_url
  end
end
