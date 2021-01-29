require "application_system_test_case"

class MovietagsTest < ApplicationSystemTestCase
  setup do
    @movietag = movietags(:one)
  end

  test "visiting the index" do
    visit movietags_url
    assert_selector "h1", text: "Movietags"
  end

  test "creating a Movietag" do
    visit movietags_url
    click_on "New Movietag"

    fill_in "Movie", with: @movietag.movie_id
    fill_in "Tag10", with: @movietag.tag10_id
    fill_in "Tag11", with: @movietag.tag11_id
    fill_in "Tag12", with: @movietag.tag12_id
    fill_in "Tag13", with: @movietag.tag13_id
    fill_in "Tag14", with: @movietag.tag14_id
    fill_in "Tag15", with: @movietag.tag15_id
    fill_in "Tag16", with: @movietag.tag16_id
    fill_in "Tag17", with: @movietag.tag17_id
    fill_in "Tag18", with: @movietag.tag18_id
    fill_in "Tag19", with: @movietag.tag19_id
    fill_in "Tag1", with: @movietag.tag1_id
    fill_in "Tag20", with: @movietag.tag20_id
    fill_in "Tag2", with: @movietag.tag2_id
    fill_in "Tag3", with: @movietag.tag3_id
    fill_in "Tag4", with: @movietag.tag4_id
    fill_in "Tag5", with: @movietag.tag5_id
    fill_in "Tag6", with: @movietag.tag6_id
    fill_in "Tag7", with: @movietag.tag7_id
    fill_in "Tag8", with: @movietag.tag8_id
    fill_in "Tag9", with: @movietag.tag9_id
    click_on "Create Movietag"

    assert_text "Movietag was successfully created"
    click_on "Back"
  end

  test "updating a Movietag" do
    visit movietags_url
    click_on "Edit", match: :first

    fill_in "Movie", with: @movietag.movie_id
    fill_in "Tag10", with: @movietag.tag10_id
    fill_in "Tag11", with: @movietag.tag11_id
    fill_in "Tag12", with: @movietag.tag12_id
    fill_in "Tag13", with: @movietag.tag13_id
    fill_in "Tag14", with: @movietag.tag14_id
    fill_in "Tag15", with: @movietag.tag15_id
    fill_in "Tag16", with: @movietag.tag16_id
    fill_in "Tag17", with: @movietag.tag17_id
    fill_in "Tag18", with: @movietag.tag18_id
    fill_in "Tag19", with: @movietag.tag19_id
    fill_in "Tag1", with: @movietag.tag1_id
    fill_in "Tag20", with: @movietag.tag20_id
    fill_in "Tag2", with: @movietag.tag2_id
    fill_in "Tag3", with: @movietag.tag3_id
    fill_in "Tag4", with: @movietag.tag4_id
    fill_in "Tag5", with: @movietag.tag5_id
    fill_in "Tag6", with: @movietag.tag6_id
    fill_in "Tag7", with: @movietag.tag7_id
    fill_in "Tag8", with: @movietag.tag8_id
    fill_in "Tag9", with: @movietag.tag9_id
    click_on "Update Movietag"

    assert_text "Movietag was successfully updated"
    click_on "Back"
  end

  test "destroying a Movietag" do
    visit movietags_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Movietag was successfully destroyed"
  end
end
