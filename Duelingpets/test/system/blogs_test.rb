require "application_system_test_case"

class BlogsTest < ApplicationSystemTestCase
  setup do
    @blog = blogs(:one)
  end

  test "visiting the index" do
    visit blogs_url
    assert_selector "h1", text: "Blogs"
  end

  test "creating a Blog" do
    visit blogs_url
    click_on "New Blog"

    fill_in "Adbanner", with: @blog.adbanner
    check "Adbannerpurchased" if @blog.adbannerpurchased
    fill_in "Admascot", with: @blog.admascot
    fill_in "Blogtype", with: @blog.blogtype_id
    fill_in "Blogviewer", with: @blog.blogviewer_id
    fill_in "Bookgroup", with: @blog.bookgroup_id
    fill_in "Created on", with: @blog.created_on
    fill_in "Description", with: @blog.description
    fill_in "Largeimage1", with: @blog.largeimage1
    check "Largeimage1purchased" if @blog.largeimage1purchased
    fill_in "Largeimage2", with: @blog.largeimage2
    check "Largeimage2purchased" if @blog.largeimage2purchased
    fill_in "Largeimage3", with: @blog.largeimage3
    check "Largeimage3purchased" if @blog.largeimage3purchased
    fill_in "Mp3", with: @blog.mp3
    check "Musicpurchased" if @blog.musicpurchased
    fill_in "Ogg", with: @blog.ogg
    check "Pointsreceived" if @blog.pointsreceived
    check "Reviewed" if @blog.reviewed
    fill_in "Reviewed on", with: @blog.reviewed_on
    fill_in "Smallimage1", with: @blog.smallimage1
    check "Smallimage1purchased" if @blog.smallimage1purchased
    fill_in "Smallimage2", with: @blog.smallimage2
    check "Smallimage2purchased" if @blog.smallimage2purchased
    fill_in "Smallimage3", with: @blog.smallimage3
    check "Smallimage3purchased" if @blog.smallimage3purchased
    fill_in "Smallimage4", with: @blog.smallimage4
    check "Smallimage4purchased" if @blog.smallimage4purchased
    fill_in "Smallimage5", with: @blog.smallimage5
    check "Smallimage5purchased" if @blog.smallimage5purchased
    fill_in "Title", with: @blog.title
    fill_in "Updated on", with: @blog.updated_on
    fill_in "User", with: @blog.user_id
    click_on "Create Blog"

    assert_text "Blog was successfully created"
    click_on "Back"
  end

  test "updating a Blog" do
    visit blogs_url
    click_on "Edit", match: :first

    fill_in "Adbanner", with: @blog.adbanner
    check "Adbannerpurchased" if @blog.adbannerpurchased
    fill_in "Admascot", with: @blog.admascot
    fill_in "Blogtype", with: @blog.blogtype_id
    fill_in "Blogviewer", with: @blog.blogviewer_id
    fill_in "Bookgroup", with: @blog.bookgroup_id
    fill_in "Created on", with: @blog.created_on
    fill_in "Description", with: @blog.description
    fill_in "Largeimage1", with: @blog.largeimage1
    check "Largeimage1purchased" if @blog.largeimage1purchased
    fill_in "Largeimage2", with: @blog.largeimage2
    check "Largeimage2purchased" if @blog.largeimage2purchased
    fill_in "Largeimage3", with: @blog.largeimage3
    check "Largeimage3purchased" if @blog.largeimage3purchased
    fill_in "Mp3", with: @blog.mp3
    check "Musicpurchased" if @blog.musicpurchased
    fill_in "Ogg", with: @blog.ogg
    check "Pointsreceived" if @blog.pointsreceived
    check "Reviewed" if @blog.reviewed
    fill_in "Reviewed on", with: @blog.reviewed_on
    fill_in "Smallimage1", with: @blog.smallimage1
    check "Smallimage1purchased" if @blog.smallimage1purchased
    fill_in "Smallimage2", with: @blog.smallimage2
    check "Smallimage2purchased" if @blog.smallimage2purchased
    fill_in "Smallimage3", with: @blog.smallimage3
    check "Smallimage3purchased" if @blog.smallimage3purchased
    fill_in "Smallimage4", with: @blog.smallimage4
    check "Smallimage4purchased" if @blog.smallimage4purchased
    fill_in "Smallimage5", with: @blog.smallimage5
    check "Smallimage5purchased" if @blog.smallimage5purchased
    fill_in "Title", with: @blog.title
    fill_in "Updated on", with: @blog.updated_on
    fill_in "User", with: @blog.user_id
    click_on "Update Blog"

    assert_text "Blog was successfully updated"
    click_on "Back"
  end

  test "destroying a Blog" do
    visit blogs_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Blog was successfully destroyed"
  end
end
