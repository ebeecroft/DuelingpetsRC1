require 'test_helper'

class ChaptertagsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @chaptertag = chaptertags(:one)
  end

  test "should get index" do
    get chaptertags_url
    assert_response :success
  end

  test "should get new" do
    get new_chaptertag_url
    assert_response :success
  end

  test "should create chaptertag" do
    assert_difference('Chaptertag.count') do
      post chaptertags_url, params: { chaptertag: { chapter_id: @chaptertag.chapter_id, tag10_id: @chaptertag.tag10_id, tag11_id: @chaptertag.tag11_id, tag12_id: @chaptertag.tag12_id, tag13_id: @chaptertag.tag13_id, tag14_id: @chaptertag.tag14_id, tag15_id: @chaptertag.tag15_id, tag16_id: @chaptertag.tag16_id, tag17_id: @chaptertag.tag17_id, tag18_id: @chaptertag.tag18_id, tag19_id: @chaptertag.tag19_id, tag1_id: @chaptertag.tag1_id, tag20_id: @chaptertag.tag20_id, tag2_id: @chaptertag.tag2_id, tag3_id: @chaptertag.tag3_id, tag4_id: @chaptertag.tag4_id, tag5_id: @chaptertag.tag5_id, tag6_id: @chaptertag.tag6_id, tag7_id: @chaptertag.tag7_id, tag8_id: @chaptertag.tag8_id, tag9_id: @chaptertag.tag9_id } }
    end

    assert_redirected_to chaptertag_url(Chaptertag.last)
  end

  test "should show chaptertag" do
    get chaptertag_url(@chaptertag)
    assert_response :success
  end

  test "should get edit" do
    get edit_chaptertag_url(@chaptertag)
    assert_response :success
  end

  test "should update chaptertag" do
    patch chaptertag_url(@chaptertag), params: { chaptertag: { chapter_id: @chaptertag.chapter_id, tag10_id: @chaptertag.tag10_id, tag11_id: @chaptertag.tag11_id, tag12_id: @chaptertag.tag12_id, tag13_id: @chaptertag.tag13_id, tag14_id: @chaptertag.tag14_id, tag15_id: @chaptertag.tag15_id, tag16_id: @chaptertag.tag16_id, tag17_id: @chaptertag.tag17_id, tag18_id: @chaptertag.tag18_id, tag19_id: @chaptertag.tag19_id, tag1_id: @chaptertag.tag1_id, tag20_id: @chaptertag.tag20_id, tag2_id: @chaptertag.tag2_id, tag3_id: @chaptertag.tag3_id, tag4_id: @chaptertag.tag4_id, tag5_id: @chaptertag.tag5_id, tag6_id: @chaptertag.tag6_id, tag7_id: @chaptertag.tag7_id, tag8_id: @chaptertag.tag8_id, tag9_id: @chaptertag.tag9_id } }
    assert_redirected_to chaptertag_url(@chaptertag)
  end

  test "should destroy chaptertag" do
    assert_difference('Chaptertag.count', -1) do
      delete chaptertag_url(@chaptertag)
    end

    assert_redirected_to chaptertags_url
  end
end
