require "application_system_test_case"

class ChaptersTest < ApplicationSystemTestCase
  setup do
    @chapter = chapters(:one)
  end

  test "visiting the index" do
    visit chapters_url
    assert_selector "h1", text: "Chapters"
  end

  test "creating a Chapter" do
    visit chapters_url
    click_on "New Chapter"

    fill_in "Book", with: @chapter.book_id
    fill_in "Bookcover", with: @chapter.bookcover
    fill_in "Bookgroup", with: @chapter.bookgroup_id
    fill_in "Created on", with: @chapter.created_on
    fill_in "Gchapter", with: @chapter.gchapter_id
    check "Pointsreceived" if @chapter.pointsreceived
    check "Reviewed" if @chapter.reviewed
    fill_in "Reviewed on", with: @chapter.reviewed_on
    fill_in "Story", with: @chapter.story
    fill_in "Storyscene", with: @chapter.storyscene
    fill_in "Title", with: @chapter.title
    fill_in "Updated on", with: @chapter.updated_on
    fill_in "User", with: @chapter.user_id
    fill_in "Voice1mp3", with: @chapter.voice1mp3
    fill_in "Voice1ogg", with: @chapter.voice1ogg
    fill_in "Voice2mp3", with: @chapter.voice2mp3
    fill_in "Voice2ogg", with: @chapter.voice2ogg
    fill_in "Voice3mp3", with: @chapter.voice3mp3
    fill_in "Voice3ogg", with: @chapter.voice3ogg
    click_on "Create Chapter"

    assert_text "Chapter was successfully created"
    click_on "Back"
  end

  test "updating a Chapter" do
    visit chapters_url
    click_on "Edit", match: :first

    fill_in "Book", with: @chapter.book_id
    fill_in "Bookcover", with: @chapter.bookcover
    fill_in "Bookgroup", with: @chapter.bookgroup_id
    fill_in "Created on", with: @chapter.created_on
    fill_in "Gchapter", with: @chapter.gchapter_id
    check "Pointsreceived" if @chapter.pointsreceived
    check "Reviewed" if @chapter.reviewed
    fill_in "Reviewed on", with: @chapter.reviewed_on
    fill_in "Story", with: @chapter.story
    fill_in "Storyscene", with: @chapter.storyscene
    fill_in "Title", with: @chapter.title
    fill_in "Updated on", with: @chapter.updated_on
    fill_in "User", with: @chapter.user_id
    fill_in "Voice1mp3", with: @chapter.voice1mp3
    fill_in "Voice1ogg", with: @chapter.voice1ogg
    fill_in "Voice2mp3", with: @chapter.voice2mp3
    fill_in "Voice2ogg", with: @chapter.voice2ogg
    fill_in "Voice3mp3", with: @chapter.voice3mp3
    fill_in "Voice3ogg", with: @chapter.voice3ogg
    click_on "Update Chapter"

    assert_text "Chapter was successfully updated"
    click_on "Back"
  end

  test "destroying a Chapter" do
    visit chapters_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Chapter was successfully destroyed"
  end
end
