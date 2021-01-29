require "application_system_test_case"

class MoviesTest < ApplicationSystemTestCase
  setup do
    @movie = movies(:one)
  end

  test "visiting the index" do
    visit movies_url
    assert_selector "h1", text: "Movies"
  end

  test "creating a Movie" do
    visit movies_url
    click_on "New Movie"

    fill_in "Bookgroup", with: @movie.bookgroup_id
    fill_in "Created on", with: @movie.created_on
    fill_in "Description", with: @movie.description
    fill_in "Mp4", with: @movie.mp4
    fill_in "Ogv", with: @movie.ogv
    check "Pointsreceived" if @movie.pointsreceived
    check "Reviewed" if @movie.reviewed
    fill_in "Reviewed on", with: @movie.reviewed_on
    fill_in "Subplaylist", with: @movie.subplaylist_id
    fill_in "Title", with: @movie.title
    fill_in "Updated on", with: @movie.updated_on
    fill_in "User", with: @movie.user_id
    click_on "Create Movie"

    assert_text "Movie was successfully created"
    click_on "Back"
  end

  test "updating a Movie" do
    visit movies_url
    click_on "Edit", match: :first

    fill_in "Bookgroup", with: @movie.bookgroup_id
    fill_in "Created on", with: @movie.created_on
    fill_in "Description", with: @movie.description
    fill_in "Mp4", with: @movie.mp4
    fill_in "Ogv", with: @movie.ogv
    check "Pointsreceived" if @movie.pointsreceived
    check "Reviewed" if @movie.reviewed
    fill_in "Reviewed on", with: @movie.reviewed_on
    fill_in "Subplaylist", with: @movie.subplaylist_id
    fill_in "Title", with: @movie.title
    fill_in "Updated on", with: @movie.updated_on
    fill_in "User", with: @movie.user_id
    click_on "Update Movie"

    assert_text "Movie was successfully updated"
    click_on "Back"
  end

  test "destroying a Movie" do
    visit movies_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Movie was successfully destroyed"
  end
end
