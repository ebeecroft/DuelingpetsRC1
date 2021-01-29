require 'test_helper'

class PouchesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @pouch = pouches(:one)
  end

  test "should get index" do
    get pouches_url
    assert_response :success
  end

  test "should get new" do
    get new_pouch_url
    assert_response :success
  end

  test "should create pouch" do
    assert_difference('Pouch.count') do
      post pouches_url, params: { pouch: { activated: @pouch.activated, admin: @pouch.admin, amount: @pouch.amount, banned: @pouch.banned, bloglevel: @pouch.bloglevel, demouser: @pouch.demouser, dreyterriumamount: @pouch.dreyterriumamount, dreyterriumlevel: @pouch.dreyterriumlevel, emeraldamount: @pouch.emeraldamount, emeraldlevel: @pouch.emeraldlevel, expiretime: @pouch.expiretime, firstdreyterrium: @pouch.firstdreyterrium, gone: @pouch.gone, last_visited: @pouch.last_visited, pouchlevel: @pouch.pouchlevel, privilege: @pouch.privilege, remember_token: @pouch.remember_token, signed_in_at: @pouch.signed_in_at, signed_out_at: @pouch.signed_out_at, user_id: @pouch.user_id } }
    end

    assert_redirected_to pouch_url(Pouch.last)
  end

  test "should show pouch" do
    get pouch_url(@pouch)
    assert_response :success
  end

  test "should get edit" do
    get edit_pouch_url(@pouch)
    assert_response :success
  end

  test "should update pouch" do
    patch pouch_url(@pouch), params: { pouch: { activated: @pouch.activated, admin: @pouch.admin, amount: @pouch.amount, banned: @pouch.banned, bloglevel: @pouch.bloglevel, demouser: @pouch.demouser, dreyterriumamount: @pouch.dreyterriumamount, dreyterriumlevel: @pouch.dreyterriumlevel, emeraldamount: @pouch.emeraldamount, emeraldlevel: @pouch.emeraldlevel, expiretime: @pouch.expiretime, firstdreyterrium: @pouch.firstdreyterrium, gone: @pouch.gone, last_visited: @pouch.last_visited, pouchlevel: @pouch.pouchlevel, privilege: @pouch.privilege, remember_token: @pouch.remember_token, signed_in_at: @pouch.signed_in_at, signed_out_at: @pouch.signed_out_at, user_id: @pouch.user_id } }
    assert_redirected_to pouch_url(@pouch)
  end

  test "should destroy pouch" do
    assert_difference('Pouch.count', -1) do
      delete pouch_url(@pouch)
    end

    assert_redirected_to pouches_url
  end
end
