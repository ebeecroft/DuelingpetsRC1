require "application_system_test_case"

class ChaptertagsTest < ApplicationSystemTestCase
  setup do
    @chaptertag = chaptertags(:one)
  end

  test "visiting the index" do
    visit chaptertags_url
    assert_selector "h1", text: "Chaptertags"
  end

  test "creating a Chaptertag" do
    visit chaptertags_url
    click_on "New Chaptertag"

    fill_in "Chapter", with: @chaptertag.chapter_id
    fill_in "Tag10", with: @chaptertag.tag10_id
    fill_in "Tag11", with: @chaptertag.tag11_id
    fill_in "Tag12", with: @chaptertag.tag12_id
    fill_in "Tag13", with: @chaptertag.tag13_id
    fill_in "Tag14", with: @chaptertag.tag14_id
    fill_in "Tag15", with: @chaptertag.tag15_id
    fill_in "Tag16", with: @chaptertag.tag16_id
    fill_in "Tag17", with: @chaptertag.tag17_id
    fill_in "Tag18", with: @chaptertag.tag18_id
    fill_in "Tag19", with: @chaptertag.tag19_id
    fill_in "Tag1", with: @chaptertag.tag1_id
    fill_in "Tag20", with: @chaptertag.tag20_id
    fill_in "Tag2", with: @chaptertag.tag2_id
    fill_in "Tag3", with: @chaptertag.tag3_id
    fill_in "Tag4", with: @chaptertag.tag4_id
    fill_in "Tag5", with: @chaptertag.tag5_id
    fill_in "Tag6", with: @chaptertag.tag6_id
    fill_in "Tag7", with: @chaptertag.tag7_id
    fill_in "Tag8", with: @chaptertag.tag8_id
    fill_in "Tag9", with: @chaptertag.tag9_id
    click_on "Create Chaptertag"

    assert_text "Chaptertag was successfully created"
    click_on "Back"
  end

  test "updating a Chaptertag" do
    visit chaptertags_url
    click_on "Edit", match: :first

    fill_in "Chapter", with: @chaptertag.chapter_id
    fill_in "Tag10", with: @chaptertag.tag10_id
    fill_in "Tag11", with: @chaptertag.tag11_id
    fill_in "Tag12", with: @chaptertag.tag12_id
    fill_in "Tag13", with: @chaptertag.tag13_id
    fill_in "Tag14", with: @chaptertag.tag14_id
    fill_in "Tag15", with: @chaptertag.tag15_id
    fill_in "Tag16", with: @chaptertag.tag16_id
    fill_in "Tag17", with: @chaptertag.tag17_id
    fill_in "Tag18", with: @chaptertag.tag18_id
    fill_in "Tag19", with: @chaptertag.tag19_id
    fill_in "Tag1", with: @chaptertag.tag1_id
    fill_in "Tag20", with: @chaptertag.tag20_id
    fill_in "Tag2", with: @chaptertag.tag2_id
    fill_in "Tag3", with: @chaptertag.tag3_id
    fill_in "Tag4", with: @chaptertag.tag4_id
    fill_in "Tag5", with: @chaptertag.tag5_id
    fill_in "Tag6", with: @chaptertag.tag6_id
    fill_in "Tag7", with: @chaptertag.tag7_id
    fill_in "Tag8", with: @chaptertag.tag8_id
    fill_in "Tag9", with: @chaptertag.tag9_id
    click_on "Update Chaptertag"

    assert_text "Chaptertag was successfully updated"
    click_on "Back"
  end

  test "destroying a Chaptertag" do
    visit chaptertags_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Chaptertag was successfully destroyed"
  end
end
