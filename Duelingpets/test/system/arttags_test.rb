require "application_system_test_case"

class ArttagsTest < ApplicationSystemTestCase
  setup do
    @arttag = arttags(:one)
  end

  test "visiting the index" do
    visit arttags_url
    assert_selector "h1", text: "Arttags"
  end

  test "creating a Arttag" do
    visit arttags_url
    click_on "New Arttag"

    fill_in "Art", with: @arttag.art_id
    fill_in "Tag10", with: @arttag.tag10_id
    fill_in "Tag11", with: @arttag.tag11_id
    fill_in "Tag12", with: @arttag.tag12_id
    fill_in "Tag13", with: @arttag.tag13_id
    fill_in "Tag14", with: @arttag.tag14_id
    fill_in "Tag15", with: @arttag.tag15_id
    fill_in "Tag16", with: @arttag.tag16_id
    fill_in "Tag17", with: @arttag.tag17_id
    fill_in "Tag18", with: @arttag.tag18_id
    fill_in "Tag19", with: @arttag.tag19_id
    fill_in "Tag1", with: @arttag.tag1_id
    fill_in "Tag20", with: @arttag.tag20_id
    fill_in "Tag2", with: @arttag.tag2_id
    fill_in "Tag3", with: @arttag.tag3_id
    fill_in "Tag4", with: @arttag.tag4_id
    fill_in "Tag5", with: @arttag.tag5_id
    fill_in "Tag6", with: @arttag.tag6_id
    fill_in "Tag7", with: @arttag.tag7_id
    fill_in "Tag8", with: @arttag.tag8_id
    fill_in "Tag9", with: @arttag.tag9_id
    click_on "Create Arttag"

    assert_text "Arttag was successfully created"
    click_on "Back"
  end

  test "updating a Arttag" do
    visit arttags_url
    click_on "Edit", match: :first

    fill_in "Art", with: @arttag.art_id
    fill_in "Tag10", with: @arttag.tag10_id
    fill_in "Tag11", with: @arttag.tag11_id
    fill_in "Tag12", with: @arttag.tag12_id
    fill_in "Tag13", with: @arttag.tag13_id
    fill_in "Tag14", with: @arttag.tag14_id
    fill_in "Tag15", with: @arttag.tag15_id
    fill_in "Tag16", with: @arttag.tag16_id
    fill_in "Tag17", with: @arttag.tag17_id
    fill_in "Tag18", with: @arttag.tag18_id
    fill_in "Tag19", with: @arttag.tag19_id
    fill_in "Tag1", with: @arttag.tag1_id
    fill_in "Tag20", with: @arttag.tag20_id
    fill_in "Tag2", with: @arttag.tag2_id
    fill_in "Tag3", with: @arttag.tag3_id
    fill_in "Tag4", with: @arttag.tag4_id
    fill_in "Tag5", with: @arttag.tag5_id
    fill_in "Tag6", with: @arttag.tag6_id
    fill_in "Tag7", with: @arttag.tag7_id
    fill_in "Tag8", with: @arttag.tag8_id
    fill_in "Tag9", with: @arttag.tag9_id
    click_on "Update Arttag"

    assert_text "Arttag was successfully updated"
    click_on "Back"
  end

  test "destroying a Arttag" do
    visit arttags_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Arttag was successfully destroyed"
  end
end
