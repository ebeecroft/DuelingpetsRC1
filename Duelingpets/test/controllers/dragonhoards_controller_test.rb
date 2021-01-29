require 'test_helper'

class DragonhoardsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @dragonhoard = dragonhoards(:one)
  end

  test "should get index" do
    get dragonhoards_url
    assert_response :success
  end

  test "should get new" do
    get new_dragonhoard_url
    assert_response :success
  end

  test "should create dragonhoard" do
    assert_difference('Dragonhoard.count') do
      post dragonhoards_url, params: { dragonhoard: { blogadbannercost: @dragonhoard.blogadbannercost, bloglargeimagecost: @dragonhoard.bloglargeimagecost, blogmusiccost: @dragonhoard.blogmusiccost, blogpoints: @dragonhoard.blogpoints, blogsmallimagecost: @dragonhoard.blogsmallimagecost, colorschemecleanup: @dragonhoard.colorschemecleanup, colorschemepoints: @dragonhoard.colorschemepoints, contestpoints: @dragonhoard.contestpoints, conversioncost: @dragonhoard.conversioncost, created_on: @dragonhoard.created_on, denholiday: @dragonhoard.denholiday, dragonimage: @dragonhoard.dragonimage, dreyterrium_extracted: @dragonhoard.dreyterrium_extracted, dreyterrium_start: @dragonhoard.dreyterrium_start, dreyterriumbasepoints: @dragonhoard.dreyterriumbasepoints, dreyterriumchange: @dragonhoard.dreyterriumchange, dreyterriumcurrent_value: @dragonhoard.dreyterriumcurrent_value, emeraldrate: @dragonhoard.emeraldrate, emeraldvalue: @dragonhoard.emeraldvalue, message: @dragonhoard.message, mp3: @dragonhoard.mp3, name: @dragonhoard.name, newdreyterriumcapacity: @dragonhoard.newdreyterriumcapacity, ogg: @dragonhoard.ogg, pointscreated: @dragonhoard.pointscreated, profit: @dragonhoard.profit, taxbase: @dragonhoard.taxbase, taxinc: @dragonhoard.taxinc, treasury: @dragonhoard.treasury } }
    end

    assert_redirected_to dragonhoard_url(Dragonhoard.last)
  end

  test "should show dragonhoard" do
    get dragonhoard_url(@dragonhoard)
    assert_response :success
  end

  test "should get edit" do
    get edit_dragonhoard_url(@dragonhoard)
    assert_response :success
  end

  test "should update dragonhoard" do
    patch dragonhoard_url(@dragonhoard), params: { dragonhoard: { blogadbannercost: @dragonhoard.blogadbannercost, bloglargeimagecost: @dragonhoard.bloglargeimagecost, blogmusiccost: @dragonhoard.blogmusiccost, blogpoints: @dragonhoard.blogpoints, blogsmallimagecost: @dragonhoard.blogsmallimagecost, colorschemecleanup: @dragonhoard.colorschemecleanup, colorschemepoints: @dragonhoard.colorschemepoints, contestpoints: @dragonhoard.contestpoints, conversioncost: @dragonhoard.conversioncost, created_on: @dragonhoard.created_on, denholiday: @dragonhoard.denholiday, dragonimage: @dragonhoard.dragonimage, dreyterrium_extracted: @dragonhoard.dreyterrium_extracted, dreyterrium_start: @dragonhoard.dreyterrium_start, dreyterriumbasepoints: @dragonhoard.dreyterriumbasepoints, dreyterriumchange: @dragonhoard.dreyterriumchange, dreyterriumcurrent_value: @dragonhoard.dreyterriumcurrent_value, emeraldrate: @dragonhoard.emeraldrate, emeraldvalue: @dragonhoard.emeraldvalue, message: @dragonhoard.message, mp3: @dragonhoard.mp3, name: @dragonhoard.name, newdreyterriumcapacity: @dragonhoard.newdreyterriumcapacity, ogg: @dragonhoard.ogg, pointscreated: @dragonhoard.pointscreated, profit: @dragonhoard.profit, taxbase: @dragonhoard.taxbase, taxinc: @dragonhoard.taxinc, treasury: @dragonhoard.treasury } }
    assert_redirected_to dragonhoard_url(@dragonhoard)
  end

  test "should destroy dragonhoard" do
    assert_difference('Dragonhoard.count', -1) do
      delete dragonhoard_url(@dragonhoard)
    end

    assert_redirected_to dragonhoards_url
  end
end
