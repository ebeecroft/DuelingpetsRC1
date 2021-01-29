require 'test_helper'

class DonorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @donor = donors(:one)
  end

  test "should get index" do
    get donors_url
    assert_response :success
  end

  test "should get new" do
    get new_donor_url
    assert_response :success
  end

  test "should create donor" do
    assert_difference('Donor.count') do
      post donors_url, params: { donor: { amount: @donor.amount, capacity: @donor.capacity, created_on: @donor.created_on, description: @donor.description, donationbox_id: @donor.donationbox_id, pointsreceived: @donor.pointsreceived, updated_on: @donor.updated_on, user_id: @donor.user_id } }
    end

    assert_redirected_to donor_url(Donor.last)
  end

  test "should show donor" do
    get donor_url(@donor)
    assert_response :success
  end

  test "should get edit" do
    get edit_donor_url(@donor)
    assert_response :success
  end

  test "should update donor" do
    patch donor_url(@donor), params: { donor: { amount: @donor.amount, capacity: @donor.capacity, created_on: @donor.created_on, description: @donor.description, donationbox_id: @donor.donationbox_id, pointsreceived: @donor.pointsreceived, updated_on: @donor.updated_on, user_id: @donor.user_id } }
    assert_redirected_to donor_url(@donor)
  end

  test "should destroy donor" do
    assert_difference('Donor.count', -1) do
      delete donor_url(@donor)
    end

    assert_redirected_to donors_url
  end
end
