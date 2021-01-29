require 'test_helper'

class UserupgradesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @userupgrade = userupgrades(:one)
  end

  test "should get index" do
    get userupgrades_url
    assert_response :success
  end

  test "should get new" do
    get new_userupgrade_url
    assert_response :success
  end

  test "should create userupgrade" do
    assert_difference('Userupgrade.count') do
      post userupgrades_url, params: { userupgrade: { blogbase: @userupgrade.blogbase, blogcost: @userupgrade.blogcost, bloginc: @userupgrade.bloginc, blogmax: @userupgrade.blogmax, dreyterriumbase: @userupgrade.dreyterriumbase, dreyterriumcost: @userupgrade.dreyterriumcost, dreyterriuminc: @userupgrade.dreyterriuminc, dreyterriummax: @userupgrade.dreyterriummax, emeraldbase: @userupgrade.emeraldbase, emeraldcost: @userupgrade.emeraldcost, emeraldinc: @userupgrade.emeraldinc, emeraldmax: @userupgrade.emeraldmax, pouchbase: @userupgrade.pouchbase, pouchcost: @userupgrade.pouchcost, pouchinc: @userupgrade.pouchinc, pouchmax: @userupgrade.pouchmax } }
    end

    assert_redirected_to userupgrade_url(Userupgrade.last)
  end

  test "should show userupgrade" do
    get userupgrade_url(@userupgrade)
    assert_response :success
  end

  test "should get edit" do
    get edit_userupgrade_url(@userupgrade)
    assert_response :success
  end

  test "should update userupgrade" do
    patch userupgrade_url(@userupgrade), params: { userupgrade: { blogbase: @userupgrade.blogbase, blogcost: @userupgrade.blogcost, bloginc: @userupgrade.bloginc, blogmax: @userupgrade.blogmax, dreyterriumbase: @userupgrade.dreyterriumbase, dreyterriumcost: @userupgrade.dreyterriumcost, dreyterriuminc: @userupgrade.dreyterriuminc, dreyterriummax: @userupgrade.dreyterriummax, emeraldbase: @userupgrade.emeraldbase, emeraldcost: @userupgrade.emeraldcost, emeraldinc: @userupgrade.emeraldinc, emeraldmax: @userupgrade.emeraldmax, pouchbase: @userupgrade.pouchbase, pouchcost: @userupgrade.pouchcost, pouchinc: @userupgrade.pouchinc, pouchmax: @userupgrade.pouchmax } }
    assert_redirected_to userupgrade_url(@userupgrade)
  end

  test "should destroy userupgrade" do
    assert_difference('Userupgrade.count', -1) do
      delete userupgrade_url(@userupgrade)
    end

    assert_redirected_to userupgrades_url
  end
end
