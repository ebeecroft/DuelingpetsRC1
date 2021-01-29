require 'test_helper'

class PmboxesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @pmbox = pmboxes(:one)
  end

  test "should get index" do
    get pmboxes_url
    assert_response :success
  end

  test "should get new" do
    get new_pmbox_url
    assert_response :success
  end

  test "should create pmbox" do
    assert_difference('Pmbox.count') do
      post pmboxes_url, params: { pmbox: { box_open: @pmbox.box_open, user_id: @pmbox.user_id } }
    end

    assert_redirected_to pmbox_url(Pmbox.last)
  end

  test "should show pmbox" do
    get pmbox_url(@pmbox)
    assert_response :success
  end

  test "should get edit" do
    get edit_pmbox_url(@pmbox)
    assert_response :success
  end

  test "should update pmbox" do
    patch pmbox_url(@pmbox), params: { pmbox: { box_open: @pmbox.box_open, user_id: @pmbox.user_id } }
    assert_redirected_to pmbox_url(@pmbox)
  end

  test "should destroy pmbox" do
    assert_difference('Pmbox.count', -1) do
      delete pmbox_url(@pmbox)
    end

    assert_redirected_to pmboxes_url
  end
end
