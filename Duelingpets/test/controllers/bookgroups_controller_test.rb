require 'test_helper'

class BookgroupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bookgroup = bookgroups(:one)
  end

  test "should get index" do
    get bookgroups_url
    assert_response :success
  end

  test "should get new" do
    get new_bookgroup_url
    assert_response :success
  end

  test "should create bookgroup" do
    assert_difference('Bookgroup.count') do
      post bookgroups_url, params: { bookgroup: { created_on: @bookgroup.created_on, name: @bookgroup.name } }
    end

    assert_redirected_to bookgroup_url(Bookgroup.last)
  end

  test "should show bookgroup" do
    get bookgroup_url(@bookgroup)
    assert_response :success
  end

  test "should get edit" do
    get edit_bookgroup_url(@bookgroup)
    assert_response :success
  end

  test "should update bookgroup" do
    patch bookgroup_url(@bookgroup), params: { bookgroup: { created_on: @bookgroup.created_on, name: @bookgroup.name } }
    assert_redirected_to bookgroup_url(@bookgroup)
  end

  test "should destroy bookgroup" do
    assert_difference('Bookgroup.count', -1) do
      delete bookgroup_url(@bookgroup)
    end

    assert_redirected_to bookgroups_url
  end
end
