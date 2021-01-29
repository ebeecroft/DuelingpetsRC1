require 'test_helper'

class RegtokensControllerTest < ActionDispatch::IntegrationTest
  setup do
    @regtoken = regtokens(:one)
  end

  test "should get index" do
    get regtokens_url
    assert_response :success
  end

  test "should get new" do
    get new_regtoken_url
    assert_response :success
  end

  test "should create regtoken" do
    assert_difference('Regtoken.count') do
      post regtokens_url, params: { regtoken: { expiretime: @regtoken.expiretime, token: @regtoken.token } }
    end

    assert_redirected_to regtoken_url(Regtoken.last)
  end

  test "should show regtoken" do
    get regtoken_url(@regtoken)
    assert_response :success
  end

  test "should get edit" do
    get edit_regtoken_url(@regtoken)
    assert_response :success
  end

  test "should update regtoken" do
    patch regtoken_url(@regtoken), params: { regtoken: { expiretime: @regtoken.expiretime, token: @regtoken.token } }
    assert_redirected_to regtoken_url(@regtoken)
  end

  test "should destroy regtoken" do
    assert_difference('Regtoken.count', -1) do
      delete regtoken_url(@regtoken)
    end

    assert_redirected_to regtokens_url
  end
end
