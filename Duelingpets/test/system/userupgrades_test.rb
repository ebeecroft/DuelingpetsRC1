require "application_system_test_case"

class UserupgradesTest < ApplicationSystemTestCase
  setup do
    @userupgrade = userupgrades(:one)
  end

  test "visiting the index" do
    visit userupgrades_url
    assert_selector "h1", text: "Userupgrades"
  end

  test "creating a Userupgrade" do
    visit userupgrades_url
    click_on "New Userupgrade"

    fill_in "Blogbase", with: @userupgrade.blogbase
    fill_in "Blogcost", with: @userupgrade.blogcost
    fill_in "Bloginc", with: @userupgrade.bloginc
    fill_in "Blogmax", with: @userupgrade.blogmax
    fill_in "Dreyterriumbase", with: @userupgrade.dreyterriumbase
    fill_in "Dreyterriumcost", with: @userupgrade.dreyterriumcost
    fill_in "Dreyterriuminc", with: @userupgrade.dreyterriuminc
    fill_in "Dreyterriummax", with: @userupgrade.dreyterriummax
    fill_in "Emeraldbase", with: @userupgrade.emeraldbase
    fill_in "Emeraldcost", with: @userupgrade.emeraldcost
    fill_in "Emeraldinc", with: @userupgrade.emeraldinc
    fill_in "Emeraldmax", with: @userupgrade.emeraldmax
    fill_in "Pouchbase", with: @userupgrade.pouchbase
    fill_in "Pouchcost", with: @userupgrade.pouchcost
    fill_in "Pouchinc", with: @userupgrade.pouchinc
    fill_in "Pouchmax", with: @userupgrade.pouchmax
    click_on "Create Userupgrade"

    assert_text "Userupgrade was successfully created"
    click_on "Back"
  end

  test "updating a Userupgrade" do
    visit userupgrades_url
    click_on "Edit", match: :first

    fill_in "Blogbase", with: @userupgrade.blogbase
    fill_in "Blogcost", with: @userupgrade.blogcost
    fill_in "Bloginc", with: @userupgrade.bloginc
    fill_in "Blogmax", with: @userupgrade.blogmax
    fill_in "Dreyterriumbase", with: @userupgrade.dreyterriumbase
    fill_in "Dreyterriumcost", with: @userupgrade.dreyterriumcost
    fill_in "Dreyterriuminc", with: @userupgrade.dreyterriuminc
    fill_in "Dreyterriummax", with: @userupgrade.dreyterriummax
    fill_in "Emeraldbase", with: @userupgrade.emeraldbase
    fill_in "Emeraldcost", with: @userupgrade.emeraldcost
    fill_in "Emeraldinc", with: @userupgrade.emeraldinc
    fill_in "Emeraldmax", with: @userupgrade.emeraldmax
    fill_in "Pouchbase", with: @userupgrade.pouchbase
    fill_in "Pouchcost", with: @userupgrade.pouchcost
    fill_in "Pouchinc", with: @userupgrade.pouchinc
    fill_in "Pouchmax", with: @userupgrade.pouchmax
    click_on "Update Userupgrade"

    assert_text "Userupgrade was successfully updated"
    click_on "Back"
  end

  test "destroying a Userupgrade" do
    visit userupgrades_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Userupgrade was successfully destroyed"
  end
end
