require 'test_helper'

class PartnersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @partner = partners(:one)
  end

  test "should get index" do
    get partners_url
    assert_response :success
  end

  test "should get new" do
    get new_partner_url
    assert_response :success
  end

  test "should create partner" do
    assert_difference('Partner.count') do
      post partners_url, params: { partner: { activepet: @partner.activepet, adoptcost: @partner.adoptcost, adopted_on: @partner.adopted_on, agility: @partner.agility, atk: @partner.atk, cfun: @partner.cfun, chp: @partner.chp, chunger: @partner.chunger, cmp: @partner.cmp, cost: @partner.cost, creature_id: @partner.creature_id, cthirst: @partner.cthirst, dead: @partner.dead, def: @partner.def, description: @partner.description, fun: @partner.fun, hp: @partner.hp, hunger: @partner.hunger, inbattle: @partner.inbattle, lives: @partner.lives, magi: @partner.magi, magitokens: @partner.magitokens, matk: @partner.matk, mdef: @partner.mdef, mexp: @partner.mexp, mlevel: @partner.mlevel, mp: @partner.mp, mstr: @partner.mstr, name: @partner.name, pexp: @partner.pexp, phytokens: @partner.phytokens, plevel: @partner.plevel, strength: @partner.strength, thirst: @partner.thirst, updated_on: @partner.updated_on, user_id: @partner.user_id } }
    end

    assert_redirected_to partner_url(Partner.last)
  end

  test "should show partner" do
    get partner_url(@partner)
    assert_response :success
  end

  test "should get edit" do
    get edit_partner_url(@partner)
    assert_response :success
  end

  test "should update partner" do
    patch partner_url(@partner), params: { partner: { activepet: @partner.activepet, adoptcost: @partner.adoptcost, adopted_on: @partner.adopted_on, agility: @partner.agility, atk: @partner.atk, cfun: @partner.cfun, chp: @partner.chp, chunger: @partner.chunger, cmp: @partner.cmp, cost: @partner.cost, creature_id: @partner.creature_id, cthirst: @partner.cthirst, dead: @partner.dead, def: @partner.def, description: @partner.description, fun: @partner.fun, hp: @partner.hp, hunger: @partner.hunger, inbattle: @partner.inbattle, lives: @partner.lives, magi: @partner.magi, magitokens: @partner.magitokens, matk: @partner.matk, mdef: @partner.mdef, mexp: @partner.mexp, mlevel: @partner.mlevel, mp: @partner.mp, mstr: @partner.mstr, name: @partner.name, pexp: @partner.pexp, phytokens: @partner.phytokens, plevel: @partner.plevel, strength: @partner.strength, thirst: @partner.thirst, updated_on: @partner.updated_on, user_id: @partner.user_id } }
    assert_redirected_to partner_url(@partner)
  end

  test "should destroy partner" do
    assert_difference('Partner.count', -1) do
      delete partner_url(@partner)
    end

    assert_redirected_to partners_url
  end
end
