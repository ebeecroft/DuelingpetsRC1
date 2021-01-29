require 'test_helper'

class BookworldsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bookworld = bookworlds(:one)
  end

  test "should get index" do
    get bookworlds_url
    assert_response :success
  end

  test "should get new" do
    get new_bookworld_url
    assert_response :success
  end

  test "should create bookworld" do
    assert_difference('Bookworld.count') do
      post bookworlds_url, params: { bookworld: { created_on: @bookworld.created_on, description: @bookworld.description, name: @bookworld.name, open_world: @bookworld.open_world, price: @bookworld.price, privateworld: @bookworld.privateworld, updated_on: @bookworld.updated_on, user_id: @bookworld.user_id } }
    end

    assert_redirected_to bookworld_url(Bookworld.last)
  end

  test "should show bookworld" do
    get bookworld_url(@bookworld)
    assert_response :success
  end

  test "should get edit" do
    get edit_bookworld_url(@bookworld)
    assert_response :success
  end

  test "should update bookworld" do
    patch bookworld_url(@bookworld), params: { bookworld: { created_on: @bookworld.created_on, description: @bookworld.description, name: @bookworld.name, open_world: @bookworld.open_world, price: @bookworld.price, privateworld: @bookworld.privateworld, updated_on: @bookworld.updated_on, user_id: @bookworld.user_id } }
    assert_redirected_to bookworld_url(@bookworld)
  end

  test "should destroy bookworld" do
    assert_difference('Bookworld.count', -1) do
      delete bookworld_url(@bookworld)
    end

    assert_redirected_to bookworlds_url
  end
end
