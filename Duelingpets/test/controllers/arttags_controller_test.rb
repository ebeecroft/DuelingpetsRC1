require 'test_helper'

class ArttagsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @arttag = arttags(:one)
  end

  test "should get index" do
    get arttags_url
    assert_response :success
  end

  test "should get new" do
    get new_arttag_url
    assert_response :success
  end

  test "should create arttag" do
    assert_difference('Arttag.count') do
      post arttags_url, params: { arttag: { art_id: @arttag.art_id, tag10_id: @arttag.tag10_id, tag11_id: @arttag.tag11_id, tag12_id: @arttag.tag12_id, tag13_id: @arttag.tag13_id, tag14_id: @arttag.tag14_id, tag15_id: @arttag.tag15_id, tag16_id: @arttag.tag16_id, tag17_id: @arttag.tag17_id, tag18_id: @arttag.tag18_id, tag19_id: @arttag.tag19_id, tag1_id: @arttag.tag1_id, tag20_id: @arttag.tag20_id, tag2_id: @arttag.tag2_id, tag3_id: @arttag.tag3_id, tag4_id: @arttag.tag4_id, tag5_id: @arttag.tag5_id, tag6_id: @arttag.tag6_id, tag7_id: @arttag.tag7_id, tag8_id: @arttag.tag8_id, tag9_id: @arttag.tag9_id } }
    end

    assert_redirected_to arttag_url(Arttag.last)
  end

  test "should show arttag" do
    get arttag_url(@arttag)
    assert_response :success
  end

  test "should get edit" do
    get edit_arttag_url(@arttag)
    assert_response :success
  end

  test "should update arttag" do
    patch arttag_url(@arttag), params: { arttag: { art_id: @arttag.art_id, tag10_id: @arttag.tag10_id, tag11_id: @arttag.tag11_id, tag12_id: @arttag.tag12_id, tag13_id: @arttag.tag13_id, tag14_id: @arttag.tag14_id, tag15_id: @arttag.tag15_id, tag16_id: @arttag.tag16_id, tag17_id: @arttag.tag17_id, tag18_id: @arttag.tag18_id, tag19_id: @arttag.tag19_id, tag1_id: @arttag.tag1_id, tag20_id: @arttag.tag20_id, tag2_id: @arttag.tag2_id, tag3_id: @arttag.tag3_id, tag4_id: @arttag.tag4_id, tag5_id: @arttag.tag5_id, tag6_id: @arttag.tag6_id, tag7_id: @arttag.tag7_id, tag8_id: @arttag.tag8_id, tag9_id: @arttag.tag9_id } }
    assert_redirected_to arttag_url(@arttag)
  end

  test "should destroy arttag" do
    assert_difference('Arttag.count', -1) do
      delete arttag_url(@arttag)
    end

    assert_redirected_to arttags_url
  end
end
