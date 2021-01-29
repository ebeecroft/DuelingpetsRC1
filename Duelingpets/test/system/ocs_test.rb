require "application_system_test_case"

class OcsTest < ApplicationSystemTestCase
  setup do
    @oc = ocs(:one)
  end

  test "visiting the index" do
    visit ocs_url
    assert_selector "h1", text: "Ocs"
  end

  test "creating a Oc" do
    visit ocs_url
    click_on "New Oc"

    fill_in "Accessories", with: @oc.accessories
    fill_in "Age", with: @oc.age
    fill_in "Alignment", with: @oc.alignment
    fill_in "Alliance", with: @oc.alliance
    fill_in "Appearance", with: @oc.appearance
    fill_in "Backgroundandhistory", with: @oc.backgroundandhistory
    fill_in "Bookgroup", with: @oc.bookgroup_id
    fill_in "Clothing", with: @oc.clothing
    fill_in "Created on", with: @oc.created_on
    fill_in "Description", with: @oc.description
    fill_in "Elements", with: @oc.elements
    fill_in "Family", with: @oc.family
    fill_in "Friends", with: @oc.friends
    fill_in "Image", with: @oc.image
    fill_in "Likesanddislikes", with: @oc.likesanddislikes
    fill_in "Mp3", with: @oc.mp3
    fill_in "Name", with: @oc.name
    fill_in "Nickname", with: @oc.nickname
    fill_in "Ogg", with: @oc.ogg
    fill_in "Personality", with: @oc.personality
    fill_in "Relatives", with: @oc.relatives
    check "Reviewed" if @oc.reviewed
    fill_in "Reviewed on", with: @oc.reviewed_on
    fill_in "Species", with: @oc.species
    fill_in "Updated on", with: @oc.updated_on
    fill_in "User", with: @oc.user_id
    fill_in "World", with: @oc.world
    click_on "Create Oc"

    assert_text "Oc was successfully created"
    click_on "Back"
  end

  test "updating a Oc" do
    visit ocs_url
    click_on "Edit", match: :first

    fill_in "Accessories", with: @oc.accessories
    fill_in "Age", with: @oc.age
    fill_in "Alignment", with: @oc.alignment
    fill_in "Alliance", with: @oc.alliance
    fill_in "Appearance", with: @oc.appearance
    fill_in "Backgroundandhistory", with: @oc.backgroundandhistory
    fill_in "Bookgroup", with: @oc.bookgroup_id
    fill_in "Clothing", with: @oc.clothing
    fill_in "Created on", with: @oc.created_on
    fill_in "Description", with: @oc.description
    fill_in "Elements", with: @oc.elements
    fill_in "Family", with: @oc.family
    fill_in "Friends", with: @oc.friends
    fill_in "Image", with: @oc.image
    fill_in "Likesanddislikes", with: @oc.likesanddislikes
    fill_in "Mp3", with: @oc.mp3
    fill_in "Name", with: @oc.name
    fill_in "Nickname", with: @oc.nickname
    fill_in "Ogg", with: @oc.ogg
    fill_in "Personality", with: @oc.personality
    fill_in "Relatives", with: @oc.relatives
    check "Reviewed" if @oc.reviewed
    fill_in "Reviewed on", with: @oc.reviewed_on
    fill_in "Species", with: @oc.species
    fill_in "Updated on", with: @oc.updated_on
    fill_in "User", with: @oc.user_id
    fill_in "World", with: @oc.world
    click_on "Update Oc"

    assert_text "Oc was successfully updated"
    click_on "Back"
  end

  test "destroying a Oc" do
    visit ocs_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Oc was successfully destroyed"
  end
end
