require 'test_helper'

class BlogviewersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @blogviewer = blogviewers(:one)
  end

  test "should get index" do
    get blogviewers_url
    assert_response :success
  end

  test "should get new" do
    get new_blogviewer_url
    assert_response :success
  end

  test "should create blogviewer" do
    assert_difference('Blogviewer.count') do
      post blogviewers_url, params: { blogviewer: { created_on: @blogviewer.created_on, name: @blogviewer.name } }
    end

    assert_redirected_to blogviewer_url(Blogviewer.last)
  end

  test "should show blogviewer" do
    get blogviewer_url(@blogviewer)
    assert_response :success
  end

  test "should get edit" do
    get edit_blogviewer_url(@blogviewer)
    assert_response :success
  end

  test "should update blogviewer" do
    patch blogviewer_url(@blogviewer), params: { blogviewer: { created_on: @blogviewer.created_on, name: @blogviewer.name } }
    assert_redirected_to blogviewer_url(@blogviewer)
  end

  test "should destroy blogviewer" do
    assert_difference('Blogviewer.count', -1) do
      delete blogviewer_url(@blogviewer)
    end

    assert_redirected_to blogviewers_url
  end
end
