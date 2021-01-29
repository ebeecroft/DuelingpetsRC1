require 'test_helper'

class CreaturesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @creature = creatures(:one)
  end

  test "should get index" do
    get creatures_url
    assert_response :success
  end

  test "should get new" do
    get new_creature_url
    assert_response :success
  end

  test "should create creature" do
    assert_difference('Creature.count') do
      post creatures_url, params: { creature: { atk: @creature.atk, charms: @creature.charms, chubbyness: @creature.chubbyness, concealment: @creature.concealment, cost: @creature.cost, created_on: @creature.created_on, creaturetype_id: @creature.creaturetype_id, def: @creature.def, description: @creature.description, flow: @creature.flow, force: @creature.force, hp: @creature.hp, hunger: @creature.hunger, image: @creature.image, level: @creature.level, lives: @creature.lives, luck: @creature.luck, mp: @creature.mp, mp3: @creature.mp3, name: @creature.name, ogg: @creature.ogg, petworth: @creature.petworth, power: @creature.power, rarity: @creature.rarity, reviewed: @creature.reviewed, reviewed_on: @creature.reviewed_on, spd: @creature.spd, starter: @creature.starter, strength: @creature.strength, thirst: @creature.thirst, updated_on: @creature.updated_on, user_id: @creature.user_id, voicemp3: @creature.voicemp3, voiceogg: @creature.voiceogg, will: @creature.will } }
    end

    assert_redirected_to creature_url(Creature.last)
  end

  test "should show creature" do
    get creature_url(@creature)
    assert_response :success
  end

  test "should get edit" do
    get edit_creature_url(@creature)
    assert_response :success
  end

  test "should update creature" do
    patch creature_url(@creature), params: { creature: { atk: @creature.atk, charms: @creature.charms, chubbyness: @creature.chubbyness, concealment: @creature.concealment, cost: @creature.cost, created_on: @creature.created_on, creaturetype_id: @creature.creaturetype_id, def: @creature.def, description: @creature.description, flow: @creature.flow, force: @creature.force, hp: @creature.hp, hunger: @creature.hunger, image: @creature.image, level: @creature.level, lives: @creature.lives, luck: @creature.luck, mp: @creature.mp, mp3: @creature.mp3, name: @creature.name, ogg: @creature.ogg, petworth: @creature.petworth, power: @creature.power, rarity: @creature.rarity, reviewed: @creature.reviewed, reviewed_on: @creature.reviewed_on, spd: @creature.spd, starter: @creature.starter, strength: @creature.strength, thirst: @creature.thirst, updated_on: @creature.updated_on, user_id: @creature.user_id, voicemp3: @creature.voicemp3, voiceogg: @creature.voiceogg, will: @creature.will } }
    assert_redirected_to creature_url(@creature)
  end

  test "should destroy creature" do
    assert_difference('Creature.count', -1) do
      delete creature_url(@creature)
    end

    assert_redirected_to creatures_url
  end
end
