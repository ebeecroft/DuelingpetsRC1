require 'test_helper'

class ItemactionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @itemaction = itemactions(:one)
  end

  test "should get index" do
    get itemactions_url
    assert_response :success
  end

  test "should get new" do
    get new_itemaction_url
    assert_response :success
  end

  test "should create itemaction" do
    assert_difference('Itemaction.count') do
      post itemactions_url, params: { itemaction: { created_on: @itemaction.created_on, name: @itemaction.name } }
    end

    assert_redirected_to itemaction_url(Itemaction.last)
  end

  test "should show itemaction" do
    get itemaction_url(@itemaction)
    assert_response :success
  end

  test "should get edit" do
    get edit_itemaction_url(@itemaction)
    assert_response :success
  end

  test "should update itemaction" do
    patch itemaction_url(@itemaction), params: { itemaction: { created_on: @itemaction.created_on, name: @itemaction.name } }
    assert_redirected_to itemaction_url(@itemaction)
  end

  test "should destroy itemaction" do
    assert_difference('Itemaction.count', -1) do
      delete itemaction_url(@itemaction)
    end

    assert_redirected_to itemactions_url
  end
end
