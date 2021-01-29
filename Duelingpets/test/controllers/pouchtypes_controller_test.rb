require 'test_helper'

class PouchtypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @pouchtype = pouchtypes(:one)
  end

  test "should get index" do
    get pouchtypes_url
    assert_response :success
  end

  test "should get new" do
    get new_pouchtype_url
    assert_response :success
  end

  test "should create pouchtype" do
    assert_difference('Pouchtype.count') do
      post pouchtypes_url, params: { pouchtype: { created_on: @pouchtype.created_on, name: @pouchtype.name } }
    end

    assert_redirected_to pouchtype_url(Pouchtype.last)
  end

  test "should show pouchtype" do
    get pouchtype_url(@pouchtype)
    assert_response :success
  end

  test "should get edit" do
    get edit_pouchtype_url(@pouchtype)
    assert_response :success
  end

  test "should update pouchtype" do
    patch pouchtype_url(@pouchtype), params: { pouchtype: { created_on: @pouchtype.created_on, name: @pouchtype.name } }
    assert_redirected_to pouchtype_url(@pouchtype)
  end

  test "should destroy pouchtype" do
    assert_difference('Pouchtype.count', -1) do
      delete pouchtype_url(@pouchtype)
    end

    assert_redirected_to pouchtypes_url
  end
end
