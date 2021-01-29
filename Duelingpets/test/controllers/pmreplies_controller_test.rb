require 'test_helper'

class PmrepliesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @pmreply = pmreplies(:one)
  end

  test "should get index" do
    get pmreplies_url
    assert_response :success
  end

  test "should get new" do
    get new_pmreply_url
    assert_response :success
  end

  test "should create pmreply" do
    assert_difference('Pmreply.count') do
      post pmreplies_url, params: { pmreply: { created_on: @pmreply.created_on, image: @pmreply.image, message: @pmreply.message, mp3: @pmreply.mp3, mp4: @pmreply.mp4, ogg: @pmreply.ogg, ogv: @pmreply.ogv, pm_id: @pmreply.pm_id, updated_on: @pmreply.updated_on, user_id: @pmreply.user_id } }
    end

    assert_redirected_to pmreply_url(Pmreply.last)
  end

  test "should show pmreply" do
    get pmreply_url(@pmreply)
    assert_response :success
  end

  test "should get edit" do
    get edit_pmreply_url(@pmreply)
    assert_response :success
  end

  test "should update pmreply" do
    patch pmreply_url(@pmreply), params: { pmreply: { created_on: @pmreply.created_on, image: @pmreply.image, message: @pmreply.message, mp3: @pmreply.mp3, mp4: @pmreply.mp4, ogg: @pmreply.ogg, ogv: @pmreply.ogv, pm_id: @pmreply.pm_id, updated_on: @pmreply.updated_on, user_id: @pmreply.user_id } }
    assert_redirected_to pmreply_url(@pmreply)
  end

  test "should destroy pmreply" do
    assert_difference('Pmreply.count', -1) do
      delete pmreply_url(@pmreply)
    end

    assert_redirected_to pmreplies_url
  end
end
