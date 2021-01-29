require 'test_helper'

class MonstersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @monster = monsters(:one)
  end

  test "should get index" do
    get monsters_url
    assert_response :success
  end

  test "should get new" do
    get new_monster_url
    assert_response :success
  end

  test "should create monster" do
    assert_difference('Monster.count') do
      post monsters_url, params: { monster: { agility: @monster.agility, atk: @monster.atk, created_on: @monster.created_on, def: @monster.def, description: @monster.description, exp: @monster.exp, hp: @monster.hp, image: @monster.image, level: @monster.level, loot: @monster.loot, magi: @monster.magi, matk: @monster.matk, mdef: @monster.mdef, mischief: @monster.mischief, monstertype_id: @monster.monstertype_id, mp: @monster.mp, mp3: @monster.mp3, mstr: @monster.mstr, name: @monster.name, ogg: @monster.ogg, rarity: @monster.rarity, retiredmonster: @monster.retiredmonster, reviewed: @monster.reviewed, reviewed_on: @monster.reviewed_on, strength: @monster.strength, updated_on: @monster.updated_on, user_id: @monster.user_id } }
    end

    assert_redirected_to monster_url(Monster.last)
  end

  test "should show monster" do
    get monster_url(@monster)
    assert_response :success
  end

  test "should get edit" do
    get edit_monster_url(@monster)
    assert_response :success
  end

  test "should update monster" do
    patch monster_url(@monster), params: { monster: { agility: @monster.agility, atk: @monster.atk, created_on: @monster.created_on, def: @monster.def, description: @monster.description, exp: @monster.exp, hp: @monster.hp, image: @monster.image, level: @monster.level, loot: @monster.loot, magi: @monster.magi, matk: @monster.matk, mdef: @monster.mdef, mischief: @monster.mischief, monstertype_id: @monster.monstertype_id, mp: @monster.mp, mp3: @monster.mp3, mstr: @monster.mstr, name: @monster.name, ogg: @monster.ogg, rarity: @monster.rarity, retiredmonster: @monster.retiredmonster, reviewed: @monster.reviewed, reviewed_on: @monster.reviewed_on, strength: @monster.strength, updated_on: @monster.updated_on, user_id: @monster.user_id } }
    assert_redirected_to monster_url(@monster)
  end

  test "should destroy monster" do
    assert_difference('Monster.count', -1) do
      delete monster_url(@monster)
    end

    assert_redirected_to monsters_url
  end
end
