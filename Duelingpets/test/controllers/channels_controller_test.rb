require 'test_helper'

class ChannelsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @channel = channels(:one)
  end

  test "should get index" do
    get channels_url
    assert_response :success
  end

  test "should get new" do
    get new_channel_url
    assert_response :success
  end

  test "should create channel" do
    assert_difference('Channel.count') do
      post channels_url, params: { channel: { bookgroup_id: @channel.bookgroup_id, created_on: @channel.created_on, description: @channel.description, mp3: @channel.mp3, music_on: @channel.music_on, name: @channel.name, ogg: @channel.ogg, privatechannel: @channel.privatechannel, updated_on: @channel.updated_on, user_id: @channel.user_id } }
    end

    assert_redirected_to channel_url(Channel.last)
  end

  test "should show channel" do
    get channel_url(@channel)
    assert_response :success
  end

  test "should get edit" do
    get edit_channel_url(@channel)
    assert_response :success
  end

  test "should update channel" do
    patch channel_url(@channel), params: { channel: { bookgroup_id: @channel.bookgroup_id, created_on: @channel.created_on, description: @channel.description, mp3: @channel.mp3, music_on: @channel.music_on, name: @channel.name, ogg: @channel.ogg, privatechannel: @channel.privatechannel, updated_on: @channel.updated_on, user_id: @channel.user_id } }
    assert_redirected_to channel_url(@channel)
  end

  test "should destroy channel" do
    assert_difference('Channel.count', -1) do
      delete channel_url(@channel)
    end

    assert_redirected_to channels_url
  end
end
