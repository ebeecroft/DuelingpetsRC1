require 'test_helper'

class SoundsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sound = sounds(:one)
  end

  test "should get index" do
    get sounds_url
    assert_response :success
  end

  test "should get new" do
    get new_sound_url
    assert_response :success
  end

  test "should create sound" do
    assert_difference('Sound.count') do
      post sounds_url, params: { sound: { bookgroup_id: @sound.bookgroup_id, created_on: @sound.created_on, description: @sound.description, mp3: @sound.mp3, ogg: @sound.ogg, pointsreceived: @sound.pointsreceived, reviewed: @sound.reviewed, reviewed_on: @sound.reviewed_on, subsheet_id: @sound.subsheet_id, title: @sound.title, updated_on: @sound.updated_on, user_id: @sound.user_id } }
    end

    assert_redirected_to sound_url(Sound.last)
  end

  test "should show sound" do
    get sound_url(@sound)
    assert_response :success
  end

  test "should get edit" do
    get edit_sound_url(@sound)
    assert_response :success
  end

  test "should update sound" do
    patch sound_url(@sound), params: { sound: { bookgroup_id: @sound.bookgroup_id, created_on: @sound.created_on, description: @sound.description, mp3: @sound.mp3, ogg: @sound.ogg, pointsreceived: @sound.pointsreceived, reviewed: @sound.reviewed, reviewed_on: @sound.reviewed_on, subsheet_id: @sound.subsheet_id, title: @sound.title, updated_on: @sound.updated_on, user_id: @sound.user_id } }
    assert_redirected_to sound_url(@sound)
  end

  test "should destroy sound" do
    assert_difference('Sound.count', -1) do
      delete sound_url(@sound)
    end

    assert_redirected_to sounds_url
  end
end
