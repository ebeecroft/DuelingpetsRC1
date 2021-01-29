require "application_system_test_case"

class OctagsTest < ApplicationSystemTestCase
  setup do
    @octag = octags(:one)
  end

  test "visiting the index" do
    visit octags_url
    assert_selector "h1", text: "Octags"
  end

  test "creating a Octag" do
    visit octags_url
    click_on "New Octag"

    fill_in "Oc", with: @octag.oc_id
    fill_in "Tag10", with: @octag.tag10_id
    fill_in "Tag11", with: @octag.tag11_id
    fill_in "Tag12", with: @octag.tag12_id
    fill_in "Tag13", with: @octag.tag13_id
    fill_in "Tag14", with: @octag.tag14_id
    fill_in "Tag15", with: @octag.tag15_id
    fill_in "Tag16", with: @octag.tag16_id
    fill_in "Tag17", with: @octag.tag17_id
    fill_in "Tag18", with: @octag.tag18_id
    fill_in "Tag19", with: @octag.tag19_id
    fill_in "Tag1", with: @octag.tag1_id
    fill_in "Tag20", with: @octag.tag20_id
    fill_in "Tag2", with: @octag.tag2_id
    fill_in "Tag3", with: @octag.tag3_id
    fill_in "Tag4", with: @octag.tag4_id
    fill_in "Tag5", with: @octag.tag5_id
    fill_in "Tag6", with: @octag.tag6_id
    fill_in "Tag7", with: @octag.tag7_id
    fill_in "Tag8", with: @octag.tag8_id
    fill_in "Tag9", with: @octag.tag9_id
    click_on "Create Octag"

    assert_text "Octag was successfully created"
    click_on "Back"
  end

  test "updating a Octag" do
    visit octags_url
    click_on "Edit", match: :first

    fill_in "Oc", with: @octag.oc_id
    fill_in "Tag10", with: @octag.tag10_id
    fill_in "Tag11", with: @octag.tag11_id
    fill_in "Tag12", with: @octag.tag12_id
    fill_in "Tag13", with: @octag.tag13_id
    fill_in "Tag14", with: @octag.tag14_id
    fill_in "Tag15", with: @octag.tag15_id
    fill_in "Tag16", with: @octag.tag16_id
    fill_in "Tag17", with: @octag.tag17_id
    fill_in "Tag18", with: @octag.tag18_id
    fill_in "Tag19", with: @octag.tag19_id
    fill_in "Tag1", with: @octag.tag1_id
    fill_in "Tag20", with: @octag.tag20_id
    fill_in "Tag2", with: @octag.tag2_id
    fill_in "Tag3", with: @octag.tag3_id
    fill_in "Tag4", with: @octag.tag4_id
    fill_in "Tag5", with: @octag.tag5_id
    fill_in "Tag6", with: @octag.tag6_id
    fill_in "Tag7", with: @octag.tag7_id
    fill_in "Tag8", with: @octag.tag8_id
    fill_in "Tag9", with: @octag.tag9_id
    click_on "Update Octag"

    assert_text "Octag was successfully updated"
    click_on "Back"
  end

  test "destroying a Octag" do
    visit octags_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Octag was successfully destroyed"
  end
end
