require 'test_helper'

class ArtpagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @artpage = artpages(:one)
  end

  test "should get index" do
    get artpages_url
    assert_response :success
  end

  test "should get new" do
    get new_artpage_url
    assert_response :success
  end

  test "should create artpage" do
    assert_difference('Artpage.count') do
      post artpages_url, params: { artpage: { art: @artpage.art, created_on: @artpage.created_on, message: @artpage.message, name: @artpage.name } }
    end

    assert_redirected_to artpage_url(Artpage.last)
  end

  test "should show artpage" do
    get artpage_url(@artpage)
    assert_response :success
  end

  test "should get edit" do
    get edit_artpage_url(@artpage)
    assert_response :success
  end

  test "should update artpage" do
    patch artpage_url(@artpage), params: { artpage: { art: @artpage.art, created_on: @artpage.created_on, message: @artpage.message, name: @artpage.name } }
    assert_redirected_to artpage_url(@artpage)
  end

  test "should destroy artpage" do
    assert_difference('Artpage.count', -1) do
      delete artpage_url(@artpage)
    end

    assert_redirected_to artpages_url
  end
end
