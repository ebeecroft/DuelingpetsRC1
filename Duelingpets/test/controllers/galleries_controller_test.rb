require 'test_helper'

class GalleriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @gallery = galleries(:one)
  end

  test "should get index" do
    get galleries_url
    assert_response :success
  end

  test "should get new" do
    get new_gallery_url
    assert_response :success
  end

  test "should create gallery" do
    assert_difference('Gallery.count') do
      post galleries_url, params: { gallery: { bookgroup_id: @gallery.bookgroup_id, created_on: @gallery.created_on, description: @gallery.description, mp3: @gallery.mp3, music_on: @gallery.music_on, name: @gallery.name, ogg: @gallery.ogg, privategallery: @gallery.privategallery, updated_on: @gallery.updated_on, user_id: @gallery.user_id } }
    end

    assert_redirected_to gallery_url(Gallery.last)
  end

  test "should show gallery" do
    get gallery_url(@gallery)
    assert_response :success
  end

  test "should get edit" do
    get edit_gallery_url(@gallery)
    assert_response :success
  end

  test "should update gallery" do
    patch gallery_url(@gallery), params: { gallery: { bookgroup_id: @gallery.bookgroup_id, created_on: @gallery.created_on, description: @gallery.description, mp3: @gallery.mp3, music_on: @gallery.music_on, name: @gallery.name, ogg: @gallery.ogg, privategallery: @gallery.privategallery, updated_on: @gallery.updated_on, user_id: @gallery.user_id } }
    assert_redirected_to gallery_url(@gallery)
  end

  test "should destroy gallery" do
    assert_difference('Gallery.count', -1) do
      delete gallery_url(@gallery)
    end

    assert_redirected_to galleries_url
  end
end
