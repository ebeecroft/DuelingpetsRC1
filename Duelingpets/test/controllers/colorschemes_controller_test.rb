require 'test_helper'

class ColorschemesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @colorscheme = colorschemes(:one)
  end

  test "should get index" do
    get colorschemes_url
    assert_response :success
  end

  test "should get new" do
    get new_colorscheme_url
    assert_response :success
  end

  test "should create colorscheme" do
    assert_difference('Colorscheme.count') do
      post colorschemes_url, params: { colorscheme: { activated: @colorscheme.activated, backgroundcolor: @colorscheme.backgroundcolor, colortype: @colorscheme.colortype, created_on: @colorscheme.created_on, defaultbuttonbackgcolor: @colorscheme.defaultbuttonbackgcolor, defaultbuttoncolor: @colorscheme.defaultbuttoncolor, democolor: @colorscheme.democolor, description: @colorscheme.description, destroybuttonbackgcolor: @colorscheme.destroybuttonbackgcolor, destroybuttoncolor: @colorscheme.destroybuttoncolor, editbuttonbackgcolor: @colorscheme.editbuttonbackgcolor, editbuttoncolor: @colorscheme.editbuttoncolor, headercolor: @colorscheme.headercolor, name: @colorscheme.name, submitbuttonbackgcolor: @colorscheme.submitbuttonbackgcolor, submitbuttoncolor: @colorscheme.submitbuttoncolor, textcolor: @colorscheme.textcolor, user_id: @colorscheme.user_id } }
    end

    assert_redirected_to colorscheme_url(Colorscheme.last)
  end

  test "should show colorscheme" do
    get colorscheme_url(@colorscheme)
    assert_response :success
  end

  test "should get edit" do
    get edit_colorscheme_url(@colorscheme)
    assert_response :success
  end

  test "should update colorscheme" do
    patch colorscheme_url(@colorscheme), params: { colorscheme: { activated: @colorscheme.activated, backgroundcolor: @colorscheme.backgroundcolor, colortype: @colorscheme.colortype, created_on: @colorscheme.created_on, defaultbuttonbackgcolor: @colorscheme.defaultbuttonbackgcolor, defaultbuttoncolor: @colorscheme.defaultbuttoncolor, democolor: @colorscheme.democolor, description: @colorscheme.description, destroybuttonbackgcolor: @colorscheme.destroybuttonbackgcolor, destroybuttoncolor: @colorscheme.destroybuttoncolor, editbuttonbackgcolor: @colorscheme.editbuttonbackgcolor, editbuttoncolor: @colorscheme.editbuttoncolor, headercolor: @colorscheme.headercolor, name: @colorscheme.name, submitbuttonbackgcolor: @colorscheme.submitbuttonbackgcolor, submitbuttoncolor: @colorscheme.submitbuttoncolor, textcolor: @colorscheme.textcolor, user_id: @colorscheme.user_id } }
    assert_redirected_to colorscheme_url(@colorscheme)
  end

  test "should destroy colorscheme" do
    assert_difference('Colorscheme.count', -1) do
      delete colorscheme_url(@colorscheme)
    end

    assert_redirected_to colorschemes_url
  end
end
