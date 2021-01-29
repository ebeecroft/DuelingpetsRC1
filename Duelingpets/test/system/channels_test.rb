require "application_system_test_case"

class ChannelsTest < ApplicationSystemTestCase
  setup do
    @channel = channels(:one)
  end

  test "visiting the index" do
    visit channels_url
    assert_selector "h1", text: "Channels"
  end

  test "creating a Channel" do
    visit channels_url
    click_on "New Channel"

    fill_in "Bookgroup", with: @channel.bookgroup_id
    fill_in "Created on", with: @channel.created_on
    fill_in "Description", with: @channel.description
    fill_in "Mp3", with: @channel.mp3
    check "Music on" if @channel.music_on
    fill_in "Name", with: @channel.name
    fill_in "Ogg", with: @channel.ogg
    check "Privatechannel" if @channel.privatechannel
    fill_in "Updated on", with: @channel.updated_on
    fill_in "User", with: @channel.user_id
    click_on "Create Channel"

    assert_text "Channel was successfully created"
    click_on "Back"
  end

  test "updating a Channel" do
    visit channels_url
    click_on "Edit", match: :first

    fill_in "Bookgroup", with: @channel.bookgroup_id
    fill_in "Created on", with: @channel.created_on
    fill_in "Description", with: @channel.description
    fill_in "Mp3", with: @channel.mp3
    check "Music on" if @channel.music_on
    fill_in "Name", with: @channel.name
    fill_in "Ogg", with: @channel.ogg
    check "Privatechannel" if @channel.privatechannel
    fill_in "Updated on", with: @channel.updated_on
    fill_in "User", with: @channel.user_id
    click_on "Update Channel"

    assert_text "Channel was successfully updated"
    click_on "Back"
  end

  test "destroying a Channel" do
    visit channels_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Channel was successfully destroyed"
  end
end
