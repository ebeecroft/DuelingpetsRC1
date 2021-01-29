require "application_system_test_case"

class ColorschemesTest < ApplicationSystemTestCase
  setup do
    @colorscheme = colorschemes(:one)
  end

  test "visiting the index" do
    visit colorschemes_url
    assert_selector "h1", text: "Colorschemes"
  end

  test "creating a Colorscheme" do
    visit colorschemes_url
    click_on "New Colorscheme"

    check "Activated" if @colorscheme.activated
    fill_in "Backgroundcolor", with: @colorscheme.backgroundcolor
    fill_in "Colortype", with: @colorscheme.colortype
    fill_in "Created on", with: @colorscheme.created_on
    fill_in "Defaultbuttonbackgcolor", with: @colorscheme.defaultbuttonbackgcolor
    fill_in "Defaultbuttoncolor", with: @colorscheme.defaultbuttoncolor
    check "Democolor" if @colorscheme.democolor
    fill_in "Description", with: @colorscheme.description
    fill_in "Destroybuttonbackgcolor", with: @colorscheme.destroybuttonbackgcolor
    fill_in "Destroybuttoncolor", with: @colorscheme.destroybuttoncolor
    fill_in "Editbuttonbackgcolor", with: @colorscheme.editbuttonbackgcolor
    fill_in "Editbuttoncolor", with: @colorscheme.editbuttoncolor
    fill_in "Headercolor", with: @colorscheme.headercolor
    fill_in "Name", with: @colorscheme.name
    fill_in "Submitbuttonbackgcolor", with: @colorscheme.submitbuttonbackgcolor
    fill_in "Submitbuttoncolor", with: @colorscheme.submitbuttoncolor
    fill_in "Textcolor", with: @colorscheme.textcolor
    fill_in "User", with: @colorscheme.user_id
    click_on "Create Colorscheme"

    assert_text "Colorscheme was successfully created"
    click_on "Back"
  end

  test "updating a Colorscheme" do
    visit colorschemes_url
    click_on "Edit", match: :first

    check "Activated" if @colorscheme.activated
    fill_in "Backgroundcolor", with: @colorscheme.backgroundcolor
    fill_in "Colortype", with: @colorscheme.colortype
    fill_in "Created on", with: @colorscheme.created_on
    fill_in "Defaultbuttonbackgcolor", with: @colorscheme.defaultbuttonbackgcolor
    fill_in "Defaultbuttoncolor", with: @colorscheme.defaultbuttoncolor
    check "Democolor" if @colorscheme.democolor
    fill_in "Description", with: @colorscheme.description
    fill_in "Destroybuttonbackgcolor", with: @colorscheme.destroybuttonbackgcolor
    fill_in "Destroybuttoncolor", with: @colorscheme.destroybuttoncolor
    fill_in "Editbuttonbackgcolor", with: @colorscheme.editbuttonbackgcolor
    fill_in "Editbuttoncolor", with: @colorscheme.editbuttoncolor
    fill_in "Headercolor", with: @colorscheme.headercolor
    fill_in "Name", with: @colorscheme.name
    fill_in "Submitbuttonbackgcolor", with: @colorscheme.submitbuttonbackgcolor
    fill_in "Submitbuttoncolor", with: @colorscheme.submitbuttoncolor
    fill_in "Textcolor", with: @colorscheme.textcolor
    fill_in "User", with: @colorscheme.user_id
    click_on "Update Colorscheme"

    assert_text "Colorscheme was successfully updated"
    click_on "Back"
  end

  test "destroying a Colorscheme" do
    visit colorschemes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Colorscheme was successfully destroyed"
  end
end
