require 'test_helper'

class DonationboxesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @donationbox = donationboxes(:one)
  end

  test "should get index" do
    get donationboxes_url
    assert_response :success
  end

  test "should get new" do
    get new_donationbox_url
    assert_response :success
  end

  test "should create donationbox" do
    assert_difference('Donationbox.count') do
      post donationboxes_url, params: { donationbox: { box_open: @donationbox.box_open, capacity: @donationbox.capacity, description: @donationbox.description, goal: @donationbox.goal, hitgoal: @donationbox.hitgoal, initialized_on: @donationbox.initialized_on, progress: @donationbox.progress, user_id: @donationbox.user_id } }
    end

    assert_redirected_to donationbox_url(Donationbox.last)
  end

  test "should show donationbox" do
    get donationbox_url(@donationbox)
    assert_response :success
  end

  test "should get edit" do
    get edit_donationbox_url(@donationbox)
    assert_response :success
  end

  test "should update donationbox" do
    patch donationbox_url(@donationbox), params: { donationbox: { box_open: @donationbox.box_open, capacity: @donationbox.capacity, description: @donationbox.description, goal: @donationbox.goal, hitgoal: @donationbox.hitgoal, initialized_on: @donationbox.initialized_on, progress: @donationbox.progress, user_id: @donationbox.user_id } }
    assert_redirected_to donationbox_url(@donationbox)
  end

  test "should destroy donationbox" do
    assert_difference('Donationbox.count', -1) do
      delete donationbox_url(@donationbox)
    end

    assert_redirected_to donationboxes_url
  end
end
