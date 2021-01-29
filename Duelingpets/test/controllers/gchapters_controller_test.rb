require 'test_helper'

class GchaptersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @gchapter = gchapters(:one)
  end

  test "should get index" do
    get gchapters_url
    assert_response :success
  end

  test "should get new" do
    get new_gchapter_url
    assert_response :success
  end

  test "should create gchapter" do
    assert_difference('Gchapter.count') do
      post gchapters_url, params: { gchapter: { created_on: @gchapter.created_on, title: @gchapter.title } }
    end

    assert_redirected_to gchapter_url(Gchapter.last)
  end

  test "should show gchapter" do
    get gchapter_url(@gchapter)
    assert_response :success
  end

  test "should get edit" do
    get edit_gchapter_url(@gchapter)
    assert_response :success
  end

  test "should update gchapter" do
    patch gchapter_url(@gchapter), params: { gchapter: { created_on: @gchapter.created_on, title: @gchapter.title } }
    assert_redirected_to gchapter_url(@gchapter)
  end

  test "should destroy gchapter" do
    assert_difference('Gchapter.count', -1) do
      delete gchapter_url(@gchapter)
    end

    assert_redirected_to gchapters_url
  end
end
