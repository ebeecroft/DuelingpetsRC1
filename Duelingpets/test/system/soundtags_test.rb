require "application_system_test_case"

class SoundtagsTest < ApplicationSystemTestCase
  setup do
    @soundtag = soundtags(:one)
  end

  test "visiting the index" do
    visit soundtags_url
    assert_selector "h1", text: "Soundtags"
  end

  test "creating a Soundtag" do
    visit soundtags_url
    click_on "New Soundtag"

    fill_in "Sound", with: @soundtag.sound_id
    fill_in "Tag10", with: @soundtag.tag10_id
    fill_in "Tag11", with: @soundtag.tag11_id
    fill_in "Tag12", with: @soundtag.tag12_id
    fill_in "Tag13", with: @soundtag.tag13_id
    fill_in "Tag14", with: @soundtag.tag14_id
    fill_in "Tag15", with: @soundtag.tag15_id
    fill_in "Tag16", with: @soundtag.tag16_id
    fill_in "Tag17", with: @soundtag.tag17_id
    fill_in "Tag18", with: @soundtag.tag18_id
    fill_in "Tag19", with: @soundtag.tag19_id
    fill_in "Tag1", with: @soundtag.tag1_id
    fill_in "Tag20", with: @soundtag.tag20_id
    fill_in "Tag2", with: @soundtag.tag2_id
    fill_in "Tag3", with: @soundtag.tag3_id
    fill_in "Tag4", with: @soundtag.tag4_id
    fill_in "Tag5", with: @soundtag.tag5_id
    fill_in "Tag6", with: @soundtag.tag6_id
    fill_in "Tag7", with: @soundtag.tag7_id
    fill_in "Tag8", with: @soundtag.tag8_id
    fill_in "Tag9", with: @soundtag.tag9_id
    click_on "Create Soundtag"

    assert_text "Soundtag was successfully created"
    click_on "Back"
  end

  test "updating a Soundtag" do
    visit soundtags_url
    click_on "Edit", match: :first

    fill_in "Sound", with: @soundtag.sound_id
    fill_in "Tag10", with: @soundtag.tag10_id
    fill_in "Tag11", with: @soundtag.tag11_id
    fill_in "Tag12", with: @soundtag.tag12_id
    fill_in "Tag13", with: @soundtag.tag13_id
    fill_in "Tag14", with: @soundtag.tag14_id
    fill_in "Tag15", with: @soundtag.tag15_id
    fill_in "Tag16", with: @soundtag.tag16_id
    fill_in "Tag17", with: @soundtag.tag17_id
    fill_in "Tag18", with: @soundtag.tag18_id
    fill_in "Tag19", with: @soundtag.tag19_id
    fill_in "Tag1", with: @soundtag.tag1_id
    fill_in "Tag20", with: @soundtag.tag20_id
    fill_in "Tag2", with: @soundtag.tag2_id
    fill_in "Tag3", with: @soundtag.tag3_id
    fill_in "Tag4", with: @soundtag.tag4_id
    fill_in "Tag5", with: @soundtag.tag5_id
    fill_in "Tag6", with: @soundtag.tag6_id
    fill_in "Tag7", with: @soundtag.tag7_id
    fill_in "Tag8", with: @soundtag.tag8_id
    fill_in "Tag9", with: @soundtag.tag9_id
    click_on "Update Soundtag"

    assert_text "Soundtag was successfully updated"
    click_on "Back"
  end

  test "destroying a Soundtag" do
    visit soundtags_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Soundtag was successfully destroyed"
  end
end
