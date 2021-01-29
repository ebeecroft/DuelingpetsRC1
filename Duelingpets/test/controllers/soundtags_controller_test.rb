require 'test_helper'

class SoundtagsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @soundtag = soundtags(:one)
  end

  test "should get index" do
    get soundtags_url
    assert_response :success
  end

  test "should get new" do
    get new_soundtag_url
    assert_response :success
  end

  test "should create soundtag" do
    assert_difference('Soundtag.count') do
      post soundtags_url, params: { soundtag: { sound_id: @soundtag.sound_id, tag10_id: @soundtag.tag10_id, tag11_id: @soundtag.tag11_id, tag12_id: @soundtag.tag12_id, tag13_id: @soundtag.tag13_id, tag14_id: @soundtag.tag14_id, tag15_id: @soundtag.tag15_id, tag16_id: @soundtag.tag16_id, tag17_id: @soundtag.tag17_id, tag18_id: @soundtag.tag18_id, tag19_id: @soundtag.tag19_id, tag1_id: @soundtag.tag1_id, tag20_id: @soundtag.tag20_id, tag2_id: @soundtag.tag2_id, tag3_id: @soundtag.tag3_id, tag4_id: @soundtag.tag4_id, tag5_id: @soundtag.tag5_id, tag6_id: @soundtag.tag6_id, tag7_id: @soundtag.tag7_id, tag8_id: @soundtag.tag8_id, tag9_id: @soundtag.tag9_id } }
    end

    assert_redirected_to soundtag_url(Soundtag.last)
  end

  test "should show soundtag" do
    get soundtag_url(@soundtag)
    assert_response :success
  end

  test "should get edit" do
    get edit_soundtag_url(@soundtag)
    assert_response :success
  end

  test "should update soundtag" do
    patch soundtag_url(@soundtag), params: { soundtag: { sound_id: @soundtag.sound_id, tag10_id: @soundtag.tag10_id, tag11_id: @soundtag.tag11_id, tag12_id: @soundtag.tag12_id, tag13_id: @soundtag.tag13_id, tag14_id: @soundtag.tag14_id, tag15_id: @soundtag.tag15_id, tag16_id: @soundtag.tag16_id, tag17_id: @soundtag.tag17_id, tag18_id: @soundtag.tag18_id, tag19_id: @soundtag.tag19_id, tag1_id: @soundtag.tag1_id, tag20_id: @soundtag.tag20_id, tag2_id: @soundtag.tag2_id, tag3_id: @soundtag.tag3_id, tag4_id: @soundtag.tag4_id, tag5_id: @soundtag.tag5_id, tag6_id: @soundtag.tag6_id, tag7_id: @soundtag.tag7_id, tag8_id: @soundtag.tag8_id, tag9_id: @soundtag.tag9_id } }
    assert_redirected_to soundtag_url(@soundtag)
  end

  test "should destroy soundtag" do
    assert_difference('Soundtag.count', -1) do
      delete soundtag_url(@soundtag)
    end

    assert_redirected_to soundtags_url
  end
end
