require 'test_helper'

class MovietagsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @movietag = movietags(:one)
  end

  test "should get index" do
    get movietags_url
    assert_response :success
  end

  test "should get new" do
    get new_movietag_url
    assert_response :success
  end

  test "should create movietag" do
    assert_difference('Movietag.count') do
      post movietags_url, params: { movietag: { movie_id: @movietag.movie_id, tag10_id: @movietag.tag10_id, tag11_id: @movietag.tag11_id, tag12_id: @movietag.tag12_id, tag13_id: @movietag.tag13_id, tag14_id: @movietag.tag14_id, tag15_id: @movietag.tag15_id, tag16_id: @movietag.tag16_id, tag17_id: @movietag.tag17_id, tag18_id: @movietag.tag18_id, tag19_id: @movietag.tag19_id, tag1_id: @movietag.tag1_id, tag20_id: @movietag.tag20_id, tag2_id: @movietag.tag2_id, tag3_id: @movietag.tag3_id, tag4_id: @movietag.tag4_id, tag5_id: @movietag.tag5_id, tag6_id: @movietag.tag6_id, tag7_id: @movietag.tag7_id, tag8_id: @movietag.tag8_id, tag9_id: @movietag.tag9_id } }
    end

    assert_redirected_to movietag_url(Movietag.last)
  end

  test "should show movietag" do
    get movietag_url(@movietag)
    assert_response :success
  end

  test "should get edit" do
    get edit_movietag_url(@movietag)
    assert_response :success
  end

  test "should update movietag" do
    patch movietag_url(@movietag), params: { movietag: { movie_id: @movietag.movie_id, tag10_id: @movietag.tag10_id, tag11_id: @movietag.tag11_id, tag12_id: @movietag.tag12_id, tag13_id: @movietag.tag13_id, tag14_id: @movietag.tag14_id, tag15_id: @movietag.tag15_id, tag16_id: @movietag.tag16_id, tag17_id: @movietag.tag17_id, tag18_id: @movietag.tag18_id, tag19_id: @movietag.tag19_id, tag1_id: @movietag.tag1_id, tag20_id: @movietag.tag20_id, tag2_id: @movietag.tag2_id, tag3_id: @movietag.tag3_id, tag4_id: @movietag.tag4_id, tag5_id: @movietag.tag5_id, tag6_id: @movietag.tag6_id, tag7_id: @movietag.tag7_id, tag8_id: @movietag.tag8_id, tag9_id: @movietag.tag9_id } }
    assert_redirected_to movietag_url(@movietag)
  end

  test "should destroy movietag" do
    assert_difference('Movietag.count', -1) do
      delete movietag_url(@movietag)
    end

    assert_redirected_to movietags_url
  end
end
