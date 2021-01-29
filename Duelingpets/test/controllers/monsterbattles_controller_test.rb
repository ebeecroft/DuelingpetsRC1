require 'test_helper'

class MonsterbattlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @monsterbattle = monsterbattles(:one)
  end

  test "should get index" do
    get monsterbattles_url
    assert_response :success
  end

  test "should get new" do
    get new_monsterbattle_url
    assert_response :success
  end

  test "should create monsterbattle" do
    assert_difference('Monsterbattle.count') do
      post monsterbattles_url, params: { monsterbattle: { battleover: @monsterbattle.battleover, creaturetype_id: @monsterbattle.creaturetype_id, dreyore_earned: @monsterbattle.dreyore_earned, ended_on: @monsterbattle.ended_on, exp_earned: @monsterbattle.exp_earned, items_earned: @monsterbattle.items_earned, monster_agility: @monsterbattle.monster_agility, monster_atk: @monsterbattle.monster_atk, monster_chp: @monsterbattle.monster_chp, monster_cmp: @monsterbattle.monster_cmp, monster_damage: @monsterbattle.monster_damage, monster_def: @monsterbattle.monster_def, monster_hp: @monsterbattle.monster_hp, monster_id: @monsterbattle.monster_id, monster_loot: @monsterbattle.monster_loot, monster_magi: @monsterbattle.monster_magi, monster_matk: @monsterbattle.monster_matk, monster_mdef: @monsterbattle.monster_mdef, monster_mischief: @monsterbattle.monster_mischief, monster_mlevel: @monsterbattle.monster_mlevel, monster_mp: @monsterbattle.monster_mp, monster_name: @monsterbattle.monster_name, monster_plevel: @monsterbattle.monster_plevel, monster_rarity: @monsterbattle.monster_rarity, monstertype_id: @monsterbattle.monstertype_id, partner_activepet: @monsterbattle.partner_activepet, partner_agility: @monsterbattle.partner_agility, partner_atk: @monsterbattle.partner_atk, partner_chp: @monsterbattle.partner_chp, partner_cmp: @monsterbattle.partner_cmp, partner_damage: @monsterbattle.partner_damage, partner_def: @monsterbattle.partner_def, partner_hp: @monsterbattle.partner_hp, partner_id: @monsterbattle.partner_id, partner_lives: @monsterbattle.partner_lives, partner_magi: @monsterbattle.partner_magi, partner_matk: @monsterbattle.partner_matk, partner_mdef: @monsterbattle.partner_mdef, partner_mexp: @monsterbattle.partner_mexp, partner_mlevel: @monsterbattle.partner_mlevel, partner_mp: @monsterbattle.partner_mp, partner_mstr: @monsterbattle.partner_mstr, partner_name: @monsterbattle.partner_name, partner_pexp: @monsterbattle.partner_pexp, partner_plevel: @monsterbattle.partner_plevel, partner_rarity: @monsterbattle.partner_rarity, partner_strength: @monsterbattle.partner_strength, round: @monsterbattle.round, started_on: @monsterbattle.started_on, tokens_earned: @monsterbattle.tokens_earned } }
    end

    assert_redirected_to monsterbattle_url(Monsterbattle.last)
  end

  test "should show monsterbattle" do
    get monsterbattle_url(@monsterbattle)
    assert_response :success
  end

  test "should get edit" do
    get edit_monsterbattle_url(@monsterbattle)
    assert_response :success
  end

  test "should update monsterbattle" do
    patch monsterbattle_url(@monsterbattle), params: { monsterbattle: { battleover: @monsterbattle.battleover, creaturetype_id: @monsterbattle.creaturetype_id, dreyore_earned: @monsterbattle.dreyore_earned, ended_on: @monsterbattle.ended_on, exp_earned: @monsterbattle.exp_earned, items_earned: @monsterbattle.items_earned, monster_agility: @monsterbattle.monster_agility, monster_atk: @monsterbattle.monster_atk, monster_chp: @monsterbattle.monster_chp, monster_cmp: @monsterbattle.monster_cmp, monster_damage: @monsterbattle.monster_damage, monster_def: @monsterbattle.monster_def, monster_hp: @monsterbattle.monster_hp, monster_id: @monsterbattle.monster_id, monster_loot: @monsterbattle.monster_loot, monster_magi: @monsterbattle.monster_magi, monster_matk: @monsterbattle.monster_matk, monster_mdef: @monsterbattle.monster_mdef, monster_mischief: @monsterbattle.monster_mischief, monster_mlevel: @monsterbattle.monster_mlevel, monster_mp: @monsterbattle.monster_mp, monster_name: @monsterbattle.monster_name, monster_plevel: @monsterbattle.monster_plevel, monster_rarity: @monsterbattle.monster_rarity, monstertype_id: @monsterbattle.monstertype_id, partner_activepet: @monsterbattle.partner_activepet, partner_agility: @monsterbattle.partner_agility, partner_atk: @monsterbattle.partner_atk, partner_chp: @monsterbattle.partner_chp, partner_cmp: @monsterbattle.partner_cmp, partner_damage: @monsterbattle.partner_damage, partner_def: @monsterbattle.partner_def, partner_hp: @monsterbattle.partner_hp, partner_id: @monsterbattle.partner_id, partner_lives: @monsterbattle.partner_lives, partner_magi: @monsterbattle.partner_magi, partner_matk: @monsterbattle.partner_matk, partner_mdef: @monsterbattle.partner_mdef, partner_mexp: @monsterbattle.partner_mexp, partner_mlevel: @monsterbattle.partner_mlevel, partner_mp: @monsterbattle.partner_mp, partner_mstr: @monsterbattle.partner_mstr, partner_name: @monsterbattle.partner_name, partner_pexp: @monsterbattle.partner_pexp, partner_plevel: @monsterbattle.partner_plevel, partner_rarity: @monsterbattle.partner_rarity, partner_strength: @monsterbattle.partner_strength, round: @monsterbattle.round, started_on: @monsterbattle.started_on, tokens_earned: @monsterbattle.tokens_earned } }
    assert_redirected_to monsterbattle_url(@monsterbattle)
  end

  test "should destroy monsterbattle" do
    assert_difference('Monsterbattle.count', -1) do
      delete monsterbattle_url(@monsterbattle)
    end

    assert_redirected_to monsterbattles_url
  end
end
