require 'test_helper'

class BlacklisteddomainsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @blacklisteddomain = blacklisteddomains(:one)
  end

  test "should get index" do
    get blacklisteddomains_url
    assert_response :success
  end

  test "should get new" do
    get new_blacklisteddomain_url
    assert_response :success
  end

  test "should create blacklisteddomain" do
    assert_difference('Blacklisteddomain.count') do
      post blacklisteddomains_url, params: { blacklisteddomain: { created_on: @blacklisteddomain.created_on, domain_only: @blacklisteddomain.domain_only, name: @blacklisteddomain.name } }
    end

    assert_redirected_to blacklisteddomain_url(Blacklisteddomain.last)
  end

  test "should show blacklisteddomain" do
    get blacklisteddomain_url(@blacklisteddomain)
    assert_response :success
  end

  test "should get edit" do
    get edit_blacklisteddomain_url(@blacklisteddomain)
    assert_response :success
  end

  test "should update blacklisteddomain" do
    patch blacklisteddomain_url(@blacklisteddomain), params: { blacklisteddomain: { created_on: @blacklisteddomain.created_on, domain_only: @blacklisteddomain.domain_only, name: @blacklisteddomain.name } }
    assert_redirected_to blacklisteddomain_url(@blacklisteddomain)
  end

  test "should destroy blacklisteddomain" do
    assert_difference('Blacklisteddomain.count', -1) do
      delete blacklisteddomain_url(@blacklisteddomain)
    end

    assert_redirected_to blacklisteddomains_url
  end
end
