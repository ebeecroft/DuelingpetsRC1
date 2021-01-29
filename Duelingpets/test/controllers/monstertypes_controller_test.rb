require 'test_helper'

class MonstertypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @monstertype = monstertypes(:one)
  end

  test "should get index" do
    get monstertypes_url
    assert_response :success
  end

  test "should get new" do
    get new_monstertype_url
    assert_response :success
  end

  test "should create monstertype" do
    assert_difference('Monstertype.count') do
      post monstertypes_url, params: { monstertype: { basecost: @monstertype.basecost, created_on: @monstertype.created_on, name: @monstertype.name } }
    end

    assert_redirected_to monstertype_url(Monstertype.last)
  end

  test "should show monstertype" do
    get monstertype_url(@monstertype)
    assert_response :success
  end

  test "should get edit" do
    get edit_monstertype_url(@monstertype)
    assert_response :success
  end

  test "should update monstertype" do
    patch monstertype_url(@monstertype), params: { monstertype: { basecost: @monstertype.basecost, created_on: @monstertype.created_on, name: @monstertype.name } }
    assert_redirected_to monstertype_url(@monstertype)
  end

  test "should destroy monstertype" do
    assert_difference('Monstertype.count', -1) do
      delete monstertype_url(@monstertype)
    end

    assert_redirected_to monstertypes_url
  end
end
