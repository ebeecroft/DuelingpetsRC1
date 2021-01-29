require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get users_url
    assert_response :success
  end

  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post users_url, params: { user: { birthday: @user.birthday, country: @user.country, country_timezone: @user.country_timezone, email: @user.email, firstname: @user.firstname, joined_on: @user.joined_on, lastname: @user.lastname, login_id: @user.login_id, password_digest: @user.password_digest, registered_on: @user.registered_on, vname: @user.vname } }
    end

    assert_redirected_to user_url(User.last)
  end

  test "should show user" do
    get user_url(@user)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_url(@user)
    assert_response :success
  end

  test "should update user" do
    patch user_url(@user), params: { user: { birthday: @user.birthday, country: @user.country, country_timezone: @user.country_timezone, email: @user.email, firstname: @user.firstname, joined_on: @user.joined_on, lastname: @user.lastname, login_id: @user.login_id, password_digest: @user.password_digest, registered_on: @user.registered_on, vname: @user.vname } }
    assert_redirected_to user_url(@user)
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete user_url(@user)
    end

    assert_redirected_to users_url
  end
end
