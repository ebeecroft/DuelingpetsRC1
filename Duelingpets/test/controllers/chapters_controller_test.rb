require 'test_helper'

class ChaptersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @chapter = chapters(:one)
  end

  test "should get index" do
    get chapters_url
    assert_response :success
  end

  test "should get new" do
    get new_chapter_url
    assert_response :success
  end

  test "should create chapter" do
    assert_difference('Chapter.count') do
      post chapters_url, params: { chapter: { book_id: @chapter.book_id, bookcover: @chapter.bookcover, bookgroup_id: @chapter.bookgroup_id, created_on: @chapter.created_on, gchapter_id: @chapter.gchapter_id, pointsreceived: @chapter.pointsreceived, reviewed: @chapter.reviewed, reviewed_on: @chapter.reviewed_on, story: @chapter.story, storyscene: @chapter.storyscene, title: @chapter.title, updated_on: @chapter.updated_on, user_id: @chapter.user_id, voice1mp3: @chapter.voice1mp3, voice1ogg: @chapter.voice1ogg, voice2mp3: @chapter.voice2mp3, voice2ogg: @chapter.voice2ogg, voice3mp3: @chapter.voice3mp3, voice3ogg: @chapter.voice3ogg } }
    end

    assert_redirected_to chapter_url(Chapter.last)
  end

  test "should show chapter" do
    get chapter_url(@chapter)
    assert_response :success
  end

  test "should get edit" do
    get edit_chapter_url(@chapter)
    assert_response :success
  end

  test "should update chapter" do
    patch chapter_url(@chapter), params: { chapter: { book_id: @chapter.book_id, bookcover: @chapter.bookcover, bookgroup_id: @chapter.bookgroup_id, created_on: @chapter.created_on, gchapter_id: @chapter.gchapter_id, pointsreceived: @chapter.pointsreceived, reviewed: @chapter.reviewed, reviewed_on: @chapter.reviewed_on, story: @chapter.story, storyscene: @chapter.storyscene, title: @chapter.title, updated_on: @chapter.updated_on, user_id: @chapter.user_id, voice1mp3: @chapter.voice1mp3, voice1ogg: @chapter.voice1ogg, voice2mp3: @chapter.voice2mp3, voice2ogg: @chapter.voice2ogg, voice3mp3: @chapter.voice3mp3, voice3ogg: @chapter.voice3ogg } }
    assert_redirected_to chapter_url(@chapter)
  end

  test "should destroy chapter" do
    assert_difference('Chapter.count', -1) do
      delete chapter_url(@chapter)
    end

    assert_redirected_to chapters_url
  end
end
