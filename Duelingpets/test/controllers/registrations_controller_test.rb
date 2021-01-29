require 'test_helper'

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @registration = registrations(:one)
  end

  test "should get index" do
    get registrations_url
    assert_response :success
  end

  test "should get new" do
    get new_registration_url
    assert_response :success
  end

  test "should create registration" do
    assert_difference('Registration.count') do
      post registrations_url, params: { registration: { accounttype_id: @registration.accounttype_id, birthday: @registration.birthday, country: @registration.country, country_timezone: @registration.country_timezone, email: @registration.email, firstname: @registration.firstname, lastname: @registration.lastname, login_id: @registration.login_id, message: @registration.message, registered_on: @registration.registered_on, vname: @registration.vname } }
    end

    assert_redirected_to registration_url(Registration.last)
  end

  test "should show registration" do
    get registration_url(@registration)
    assert_response :success
  end

  test "should get edit" do
    get edit_registration_url(@registration)
    assert_response :success
  end

  test "should update registration" do
    patch registration_url(@registration), params: { registration: { accounttype_id: @registration.accounttype_id, birthday: @registration.birthday, country: @registration.country, country_timezone: @registration.country_timezone, email: @registration.email, firstname: @registration.firstname, lastname: @registration.lastname, login_id: @registration.login_id, message: @registration.message, registered_on: @registration.registered_on, vname: @registration.vname } }
    assert_redirected_to registration_url(@registration)
  end

  test "should destroy registration" do
    assert_difference('Registration.count', -1) do
      delete registration_url(@registration)
    end

    assert_redirected_to registrations_url
  end
end
