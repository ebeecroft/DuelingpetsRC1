require 'test_helper'

class JukeboxesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @jukebox = jukeboxes(:one)
  end

  test "should get index" do
    get jukeboxes_url
    assert_response :success
  end

  test "should get new" do
    get new_jukebox_url
    assert_response :success
  end

  test "should create jukebox" do
    assert_difference('Jukebox.count') do
      post jukeboxes_url, params: { jukebox: { bookgroup_id: @jukebox.bookgroup_id, created_on: @jukebox.created_on, description: @jukebox.description, mp3: @jukebox.mp3, music_on: @jukebox.music_on, name: @jukebox.name, ogg: @jukebox.ogg, privatejukebox: @jukebox.privatejukebox, updated_on: @jukebox.updated_on, user_id: @jukebox.user_id } }
    end

    assert_redirected_to jukebox_url(Jukebox.last)
  end

  test "should show jukebox" do
    get jukebox_url(@jukebox)
    assert_response :success
  end

  test "should get edit" do
    get edit_jukebox_url(@jukebox)
    assert_response :success
  end

  test "should update jukebox" do
    patch jukebox_url(@jukebox), params: { jukebox: { bookgroup_id: @jukebox.bookgroup_id, created_on: @jukebox.created_on, description: @jukebox.description, mp3: @jukebox.mp3, music_on: @jukebox.music_on, name: @jukebox.name, ogg: @jukebox.ogg, privatejukebox: @jukebox.privatejukebox, updated_on: @jukebox.updated_on, user_id: @jukebox.user_id } }
    assert_redirected_to jukebox_url(@jukebox)
  end

  test "should destroy jukebox" do
    assert_difference('Jukebox.count', -1) do
      delete jukebox_url(@jukebox)
    end

    assert_redirected_to jukeboxes_url
  end
end
