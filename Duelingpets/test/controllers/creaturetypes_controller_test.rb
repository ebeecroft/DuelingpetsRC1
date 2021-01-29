require 'test_helper'

class CreaturetypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @creaturetype = creaturetypes(:one)
  end

  test "should get index" do
    get creaturetypes_url
    assert_response :success
  end

  test "should get new" do
    get new_creaturetype_url
    assert_response :success
  end

  test "should create creaturetype" do
    assert_difference('Creaturetype.count') do
      post creaturetypes_url, params: { creaturetype: { basecost: @creaturetype.basecost, created_on: @creaturetype.created_on, dreyterriumcost: @creaturetype.dreyterriumcost, name: @creaturetype.name } }
    end

    assert_redirected_to creaturetype_url(Creaturetype.last)
  end

  test "should show creaturetype" do
    get creaturetype_url(@creaturetype)
    assert_response :success
  end

  test "should get edit" do
    get edit_creaturetype_url(@creaturetype)
    assert_response :success
  end

  test "should update creaturetype" do
    patch creaturetype_url(@creaturetype), params: { creaturetype: { basecost: @creaturetype.basecost, created_on: @creaturetype.created_on, dreyterriumcost: @creaturetype.dreyterriumcost, name: @creaturetype.name } }
    assert_redirected_to creaturetype_url(@creaturetype)
  end

  test "should destroy creaturetype" do
    assert_difference('Creaturetype.count', -1) do
      delete creaturetype_url(@creaturetype)
    end

    assert_redirected_to creaturetypes_url
  end
end
