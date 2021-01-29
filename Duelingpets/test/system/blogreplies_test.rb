require "application_system_test_case"

class BlogrepliesTest < ApplicationSystemTestCase
  setup do
    @blogreply = blogreplies(:one)
  end

  test "visiting the index" do
    visit blogreplies_url
    assert_selector "h1", text: "Blogreplies"
  end

  test "creating a Blogreply" do
    visit blogreplies_url
    click_on "New Blogreply"

    fill_in "Blog", with: @blogreply.blog_id
    fill_in "Created on", with: @blogreply.created_on
    fill_in "Message", with: @blogreply.message
    check "Reviewed" if @blogreply.reviewed
    fill_in "Reviewed on", with: @blogreply.reviewed_on
    fill_in "Updated on", with: @blogreply.updated_on
    fill_in "User", with: @blogreply.user_id
    click_on "Create Blogreply"

    assert_text "Blogreply was successfully created"
    click_on "Back"
  end

  test "updating a Blogreply" do
    visit blogreplies_url
    click_on "Edit", match: :first

    fill_in "Blog", with: @blogreply.blog_id
    fill_in "Created on", with: @blogreply.created_on
    fill_in "Message", with: @blogreply.message
    check "Reviewed" if @blogreply.reviewed
    fill_in "Reviewed on", with: @blogreply.reviewed_on
    fill_in "Updated on", with: @blogreply.updated_on
    fill_in "User", with: @blogreply.user_id
    click_on "Update Blogreply"

    assert_text "Blogreply was successfully updated"
    click_on "Back"
  end

  test "destroying a Blogreply" do
    visit blogreplies_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Blogreply was successfully destroyed"
  end
end
