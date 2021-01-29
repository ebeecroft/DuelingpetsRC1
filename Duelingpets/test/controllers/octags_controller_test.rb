require 'test_helper'

class OctagsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @octag = octags(:one)
  end

  test "should get index" do
    get octags_url
    assert_response :success
  end

  test "should get new" do
    get new_octag_url
    assert_response :success
  end

  test "should create octag" do
    assert_difference('Octag.count') do
      post octags_url, params: { octag: { oc_id: @octag.oc_id, tag10_id: @octag.tag10_id, tag11_id: @octag.tag11_id, tag12_id: @octag.tag12_id, tag13_id: @octag.tag13_id, tag14_id: @octag.tag14_id, tag15_id: @octag.tag15_id, tag16_id: @octag.tag16_id, tag17_id: @octag.tag17_id, tag18_id: @octag.tag18_id, tag19_id: @octag.tag19_id, tag1_id: @octag.tag1_id, tag20_id: @octag.tag20_id, tag2_id: @octag.tag2_id, tag3_id: @octag.tag3_id, tag4_id: @octag.tag4_id, tag5_id: @octag.tag5_id, tag6_id: @octag.tag6_id, tag7_id: @octag.tag7_id, tag8_id: @octag.tag8_id, tag9_id: @octag.tag9_id } }
    end

    assert_redirected_to octag_url(Octag.last)
  end

  test "should show octag" do
    get octag_url(@octag)
    assert_response :success
  end

  test "should get edit" do
    get edit_octag_url(@octag)
    assert_response :success
  end

  test "should update octag" do
    patch octag_url(@octag), params: { octag: { oc_id: @octag.oc_id, tag10_id: @octag.tag10_id, tag11_id: @octag.tag11_id, tag12_id: @octag.tag12_id, tag13_id: @octag.tag13_id, tag14_id: @octag.tag14_id, tag15_id: @octag.tag15_id, tag16_id: @octag.tag16_id, tag17_id: @octag.tag17_id, tag18_id: @octag.tag18_id, tag19_id: @octag.tag19_id, tag1_id: @octag.tag1_id, tag20_id: @octag.tag20_id, tag2_id: @octag.tag2_id, tag3_id: @octag.tag3_id, tag4_id: @octag.tag4_id, tag5_id: @octag.tag5_id, tag6_id: @octag.tag6_id, tag7_id: @octag.tag7_id, tag8_id: @octag.tag8_id, tag9_id: @octag.tag9_id } }
    assert_redirected_to octag_url(@octag)
  end

  test "should destroy octag" do
    assert_difference('Octag.count', -1) do
      delete octag_url(@octag)
    end

    assert_redirected_to octags_url
  end
end
