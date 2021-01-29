require 'test_helper'

class OcsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @oc = ocs(:one)
  end

  test "should get index" do
    get ocs_url
    assert_response :success
  end

  test "should get new" do
    get new_oc_url
    assert_response :success
  end

  test "should create oc" do
    assert_difference('Oc.count') do
      post ocs_url, params: { oc: { accessories: @oc.accessories, age: @oc.age, alignment: @oc.alignment, alliance: @oc.alliance, appearance: @oc.appearance, backgroundandhistory: @oc.backgroundandhistory, bookgroup_id: @oc.bookgroup_id, clothing: @oc.clothing, created_on: @oc.created_on, description: @oc.description, elements: @oc.elements, family: @oc.family, friends: @oc.friends, image: @oc.image, likesanddislikes: @oc.likesanddislikes, mp3: @oc.mp3, name: @oc.name, nickname: @oc.nickname, ogg: @oc.ogg, personality: @oc.personality, relatives: @oc.relatives, reviewed: @oc.reviewed, reviewed_on: @oc.reviewed_on, species: @oc.species, updated_on: @oc.updated_on, user_id: @oc.user_id, world: @oc.world } }
    end

    assert_redirected_to oc_url(Oc.last)
  end

  test "should show oc" do
    get oc_url(@oc)
    assert_response :success
  end

  test "should get edit" do
    get edit_oc_url(@oc)
    assert_response :success
  end

  test "should update oc" do
    patch oc_url(@oc), params: { oc: { accessories: @oc.accessories, age: @oc.age, alignment: @oc.alignment, alliance: @oc.alliance, appearance: @oc.appearance, backgroundandhistory: @oc.backgroundandhistory, bookgroup_id: @oc.bookgroup_id, clothing: @oc.clothing, created_on: @oc.created_on, description: @oc.description, elements: @oc.elements, family: @oc.family, friends: @oc.friends, image: @oc.image, likesanddislikes: @oc.likesanddislikes, mp3: @oc.mp3, name: @oc.name, nickname: @oc.nickname, ogg: @oc.ogg, personality: @oc.personality, relatives: @oc.relatives, reviewed: @oc.reviewed, reviewed_on: @oc.reviewed_on, species: @oc.species, updated_on: @oc.updated_on, user_id: @oc.user_id, world: @oc.world } }
    assert_redirected_to oc_url(@oc)
  end

  test "should destroy oc" do
    assert_difference('Oc.count', -1) do
      delete oc_url(@oc)
    end

    assert_redirected_to ocs_url
  end
end
