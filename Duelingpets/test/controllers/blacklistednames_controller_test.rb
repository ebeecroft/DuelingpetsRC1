require 'test_helper'

class BlacklistednamesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @blacklistedname = blacklistednames(:one)
  end

  test "should get index" do
    get blacklistednames_url
    assert_response :success
  end

  test "should get new" do
    get new_blacklistedname_url
    assert_response :success
  end

  test "should create blacklistedname" do
    assert_difference('Blacklistedname.count') do
      post blacklistednames_url, params: { blacklistedname: { created_on: @blacklistedname.created_on, name: @blacklistedname.name } }
    end

    assert_redirected_to blacklistedname_url(Blacklistedname.last)
  end

  test "should show blacklistedname" do
    get blacklistedname_url(@blacklistedname)
    assert_response :success
  end

  test "should get edit" do
    get edit_blacklistedname_url(@blacklistedname)
    assert_response :success
  end

  test "should update blacklistedname" do
    patch blacklistedname_url(@blacklistedname), params: { blacklistedname: { created_on: @blacklistedname.created_on, name: @blacklistedname.name } }
    assert_redirected_to blacklistedname_url(@blacklistedname)
  end

  test "should destroy blacklistedname" do
    assert_difference('Blacklistedname.count', -1) do
      delete blacklistedname_url(@blacklistedname)
    end

    assert_redirected_to blacklistednames_url
  end
end
