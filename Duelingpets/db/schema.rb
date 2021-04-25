# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_03_21_034706) do

  create_table "artpages", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.text "message"
    t.datetime "created_on"
    t.string "art"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "arts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "image"
    t.string "ogg"
    t.string "mp3"
    t.datetime "created_on"
    t.datetime "updated_on"
    t.datetime "reviewed_on"
    t.integer "user_id"
    t.integer "bookgroup_id"
    t.integer "subfolder_id"
    t.boolean "reviewed", default: false
    t.boolean "pointsreceived", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "arttags", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "art_id"
    t.integer "tag1_id"
    t.integer "tag2_id"
    t.integer "tag3_id"
    t.integer "tag4_id"
    t.integer "tag5_id"
    t.integer "tag6_id"
    t.integer "tag7_id"
    t.integer "tag8_id"
    t.integer "tag9_id"
    t.integer "tag10_id"
    t.integer "tag11_id"
    t.integer "tag12_id"
    t.integer "tag13_id"
    t.integer "tag14_id"
    t.integer "tag15_id"
    t.integer "tag16_id"
    t.integer "tag17_id"
    t.integer "tag18_id"
    t.integer "tag19_id"
    t.integer "tag20_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "baseincs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.integer "amount"
    t.datetime "created_on"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "baserates", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.float "amount", limit: 53
    t.datetime "created_on"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "blacklisteddomains", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_on"
    t.boolean "domain_only", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "blacklistednames", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_on"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "blogreplies", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "message"
    t.datetime "created_on"
    t.datetime "updated_on"
    t.datetime "reviewed_on"
    t.integer "user_id"
    t.integer "blog_id"
    t.boolean "reviewed", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "blogs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "ogg"
    t.string "mp3"
    t.string "adbanner"
    t.string "admascot"
    t.string "largeimage1"
    t.string "largeimage2"
    t.string "largeimage3"
    t.string "smallimage1"
    t.string "smallimage2"
    t.string "smallimage3"
    t.string "smallimage4"
    t.string "smallimage5"
    t.datetime "created_on"
    t.datetime "reviewed_on"
    t.datetime "updated_on"
    t.integer "blogtype_id"
    t.integer "bookgroup_id"
    t.integer "gviewer_id"
    t.integer "user_id"
    t.boolean "box_open", default: false
    t.boolean "largeimage1purchased", default: false
    t.boolean "largeimage2purchased", default: false
    t.boolean "largeimage3purchased", default: false
    t.boolean "smallimage1purchased", default: false
    t.boolean "smallimage2purchased", default: false
    t.boolean "smallimage3purchased", default: false
    t.boolean "smallimage4purchased", default: false
    t.boolean "smallimage5purchased", default: false
    t.boolean "musicpurchased", default: false
    t.boolean "adbannerpurchased", default: false
    t.boolean "pointsreceived", default: false
    t.boolean "reviewed", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "blogtypes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_on"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bookgroups", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_on"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "books", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_on"
    t.datetime "updated_on"
    t.integer "user_id"
    t.integer "bookgroup_id"
    t.integer "bookworld_id"
    t.integer "gviewer_id"
    t.boolean "collab_mode", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bookworlds", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "price"
    t.datetime "created_on"
    t.datetime "updated_on"
    t.integer "user_id"
    t.boolean "open_world", default: false
    t.boolean "privateworld", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "channels", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "ogg"
    t.string "mp3"
    t.datetime "created_on"
    t.datetime "updated_on"
    t.integer "user_id"
    t.integer "bookgroup_id"
    t.integer "gviewer_id"
    t.boolean "music_on", default: false
    t.boolean "privatechannel", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "chapters", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.text "story"
    t.string "bookcover"
    t.string "storyscene1"
    t.string "voice1ogg"
    t.string "voice1mp3"
    t.string "voice2ogg"
    t.string "voice2mp3"
    t.string "voice3ogg"
    t.string "voice3mp3"
    t.datetime "created_on"
    t.datetime "updated_on"
    t.datetime "reviewed_on"
    t.integer "user_id"
    t.integer "bookgroup_id"
    t.integer "book_id"
    t.integer "gchapter_id", default: 1
    t.boolean "reviewed", default: false
    t.boolean "pointsreceived", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "chaptertags", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "chapter_id"
    t.integer "tag1_id"
    t.integer "tag2_id"
    t.integer "tag3_id"
    t.integer "tag4_id"
    t.integer "tag5_id"
    t.integer "tag6_id"
    t.integer "tag7_id"
    t.integer "tag8_id"
    t.integer "tag9_id"
    t.integer "tag10_id"
    t.integer "tag11_id"
    t.integer "tag12_id"
    t.integer "tag13_id"
    t.integer "tag14_id"
    t.integer "tag15_id"
    t.integer "tag16_id"
    t.integer "tag17_id"
    t.integer "tag18_id"
    t.integer "tag19_id"
    t.integer "tag20_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "colorschemes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "colortype"
    t.text "description"
    t.datetime "created_on"
    t.datetime "updated_on"
    t.integer "user_id"
    t.boolean "activated", default: false
    t.boolean "nightcolor", default: false
    t.boolean "democolor", default: false
    t.string "backgroundcolor", default: "#000000"
    t.string "headercolor", default: "#000000"
    t.string "subheader1color", default: "#000000"
    t.string "subheader2color", default: "#000000"
    t.string "subheader3color", default: "#000000"
    t.string "textcolor", default: "#000000"
    t.string "editbuttoncolor", default: "#000000"
    t.string "editbuttonbackgcolor", default: "#000000"
    t.string "destroybuttoncolor", default: "#000000"
    t.string "destroybuttonbackgcolor", default: "#000000"
    t.string "submitbuttoncolor", default: "#000000"
    t.string "submitbuttonbackgcolor", default: "#000000"
    t.string "navigationcolor", default: "#000000"
    t.string "navigationlinkcolor", default: "#000000"
    t.string "navigationhovercolor", default: "#000000"
    t.string "navigationhoverbackgcolor", default: "#000000"
    t.string "onlinestatuscolor", default: "#000000"
    t.string "profilecolor", default: "#000000"
    t.string "profilehovercolor", default: "#000000"
    t.string "profilehoverbackgcolor", default: "#000000"
    t.string "sessioncolor", default: "#000000"
    t.string "navlinkcolor", default: "#000000"
    t.string "navlinkhovercolor", default: "#000000"
    t.string "navlinkhoverbackgcolor", default: "#000000"
    t.string "explanationborder", default: "#000000"
    t.string "explanationbackgcolor", default: "#000000"
    t.string "explanheadercolor", default: "#000000"
    t.string "explantextcolor", default: "#000000"
    t.string "errorfieldcolor", default: "#000000"
    t.string "errorcolor", default: "#000000"
    t.string "warningcolor", default: "#000000"
    t.string "notificationcolor", default: "#000000"
    t.string "successcolor", default: "#000000"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "creatures", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "image"
    t.string "activepet"
    t.string "ogg"
    t.string "mp3"
    t.string "voiceogg"
    t.string "voicemp3"
    t.integer "level", default: 0
    t.integer "hp", default: 0
    t.integer "atk", default: 0
    t.integer "def", default: 0
    t.integer "agility", default: 0
    t.integer "strength", default: 0
    t.integer "mp", default: 0
    t.integer "matk", default: 0
    t.integer "mdef", default: 0
    t.integer "magi", default: 0
    t.integer "mstr", default: 0
    t.integer "hunger", default: 0
    t.integer "thirst", default: 0
    t.integer "fun", default: 0
    t.integer "lives", default: 0
    t.integer "rarity", default: 1
    t.boolean "unlimitedlives", default: false
    t.boolean "retiredpet", default: false
    t.boolean "starter", default: false
    t.integer "emeraldcost", default: 0
    t.integer "cost"
    t.datetime "created_on"
    t.datetime "updated_on"
    t.datetime "reviewed_on"
    t.integer "user_id"
    t.integer "creaturetype_id"
    t.integer "element_id"
    t.boolean "reviewed", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "creaturetypes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_on"
    t.integer "basehp"
    t.integer "baseatk"
    t.integer "basedef"
    t.integer "baseagi"
    t.integer "basestr"
    t.integer "basehunger"
    t.integer "basethirst"
    t.integer "basefun"
    t.integer "basecost"
    t.integer "dreyterriumcost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "difficulties", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.integer "pointdebt", default: 0
    t.integer "pointloan", default: 0
    t.integer "emeralddebt", default: 0
    t.integer "emeraldloan", default: 0
    t.datetime "created_on"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "donationboxes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "description"
    t.integer "progress"
    t.integer "goal"
    t.integer "capacity"
    t.datetime "initialized_on"
    t.integer "user_id"
    t.boolean "hitgoal", default: false
    t.boolean "box_open", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "donors", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "description"
    t.integer "amount", default: 0
    t.integer "capacity", default: 50000
    t.datetime "created_on"
    t.datetime "updated_on"
    t.integer "user_id"
    t.integer "donationbox_id"
    t.boolean "pointsreceived", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dragonhoards", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.text "message"
    t.datetime "created_on"
    t.datetime "updated_on"
    t.string "ogg"
    t.string "mp3"
    t.integer "basecost", default: 0
    t.float "baserate", limit: 53
    t.integer "treasury", default: 0
    t.integer "contestpoints", default: 0
    t.integer "profit", default: 0
    t.integer "warepoints", default: 0
    t.integer "helperpoints", default: 0
    t.integer "emeralds", default: 0
    t.string "dragonimage"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dreyores", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.integer "cur", default: 0
    t.integer "cap"
    t.integer "baseinc"
    t.integer "change"
    t.integer "price"
    t.integer "extracted", default: 0
    t.datetime "created_on"
    t.datetime "updated_on"
    t.integer "dragonhoard_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "economies", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "econtype"
    t.string "content_type"
    t.integer "amount"
    t.datetime "created_on"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "elementcharts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "sstrength_id"
    t.integer "estrength_id"
    t.integer "sweak_id"
    t.integer "eweak_id"
    t.integer "element_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "elements", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "itemart"
    t.datetime "created_on"
    t.datetime "updated_on"
    t.datetime "reviewed_on"
    t.integer "user_id"
    t.boolean "reviewed", default: false
    t.boolean "pointsreceived", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "equips", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "capacity", default: 3
    t.integer "partner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "equipslots", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.integer "equip_id"
    t.integer "item1_id"
    t.integer "curdur1", default: 0
    t.integer "startdur1", default: 0
    t.integer "item2_id"
    t.integer "curdur2", default: 0
    t.integer "startdur2", default: 0
    t.integer "item3_id"
    t.integer "curdur3", default: 0
    t.integer "startdur3", default: 0
    t.integer "item4_id"
    t.integer "curdur4", default: 0
    t.integer "startdur4", default: 0
    t.integer "item5_id"
    t.integer "curdur5", default: 0
    t.integer "startdur5", default: 0
    t.integer "item6_id"
    t.integer "curdur6", default: 0
    t.integer "startdur6", default: 0
    t.integer "item7_id"
    t.integer "curdur7", default: 0
    t.integer "startdur7", default: 0
    t.integer "item8_id"
    t.integer "curdur8", default: 0
    t.integer "startdur8", default: 0
    t.boolean "activeslot", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "faqs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "goal"
    t.text "prereqs"
    t.text "steps"
    t.datetime "created_on"
    t.datetime "updated_on"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fieldcosts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.integer "amount"
    t.string "econtype"
    t.datetime "created_on"
    t.datetime "updated_on"
    t.integer "baseinc_id"
    t.integer "dragonhoard_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fights", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "win", default: 0
    t.integer "draw", default: 0
    t.integer "loss", default: 0
    t.integer "partner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "galleries", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "ogg"
    t.string "mp3"
    t.datetime "created_on"
    t.datetime "updated_on"
    t.integer "user_id"
    t.integer "bookgroup_id"
    t.integer "gviewer_id"
    t.boolean "music_on", default: false
    t.boolean "privategallery", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "gameinfos", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "difficulty_id"
    t.boolean "lives_enabled", default: false
    t.boolean "ageing_enabled", default: false
    t.datetime "activated_on"
    t.boolean "startgame", default: false
    t.boolean "gamecompleted", default: false
    t.integer "success", default: 0
    t.integer "failure", default: 0
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "gchapters", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.datetime "created_on"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "gviewers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_on"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "inventories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "capacity", default: 60
    t.integer "petcapacity", default: 80
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "inventoryslots", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.integer "inventory_id"
    t.integer "item1_id"
    t.integer "curdur1", default: 0
    t.integer "startdur1", default: 0
    t.integer "qty1", default: 0
    t.integer "item2_id"
    t.integer "curdur2", default: 0
    t.integer "startdur2", default: 0
    t.integer "qty2", default: 0
    t.integer "item3_id"
    t.integer "curdur3", default: 0
    t.integer "startdur3", default: 0
    t.integer "qty3", default: 0
    t.integer "item4_id"
    t.integer "curdur4", default: 0
    t.integer "startdur4", default: 0
    t.integer "qty4", default: 0
    t.integer "item5_id"
    t.integer "curdur5", default: 0
    t.integer "startdur5", default: 0
    t.integer "qty5", default: 0
    t.integer "item6_id"
    t.integer "curdur6", default: 0
    t.integer "startdur6", default: 0
    t.integer "qty6", default: 0
    t.integer "item7_id"
    t.integer "curdur7", default: 0
    t.integer "startdur7", default: 0
    t.integer "qty7", default: 0
    t.integer "item8_id"
    t.integer "curdur8", default: 0
    t.integer "startdur8", default: 0
    t.integer "qty8", default: 0
    t.integer "item9_id"
    t.integer "curdur9", default: 0
    t.integer "startdur9", default: 0
    t.integer "qty9", default: 0
    t.integer "item10_id"
    t.integer "curdur10", default: 0
    t.integer "startdur10", default: 0
    t.integer "qty10", default: 0
    t.integer "item11_id"
    t.integer "curdur11", default: 0
    t.integer "startdur11", default: 0
    t.integer "qty11", default: 0
    t.integer "item12_id"
    t.integer "curdur12", default: 0
    t.integer "startdur12", default: 0
    t.integer "qty12", default: 0
    t.integer "item13_id"
    t.integer "curdur13", default: 0
    t.integer "startdur13", default: 0
    t.integer "qty13", default: 0
    t.integer "item14_id"
    t.integer "curdur14", default: 0
    t.integer "startdur14", default: 0
    t.integer "qty14", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "itemactions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_on"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "itemart"
    t.integer "hp", default: 0
    t.integer "atk", default: 0
    t.integer "def", default: 0
    t.integer "agility", default: 0
    t.integer "strength", default: 0
    t.integer "mp", default: 0
    t.integer "matk", default: 0
    t.integer "mdef", default: 0
    t.integer "magi", default: 0
    t.integer "mstr", default: 0
    t.integer "hunger", default: 0
    t.integer "thirst", default: 0
    t.integer "fun", default: 0
    t.integer "durability", default: 1
    t.integer "rarity", default: 1
    t.boolean "retireditem", default: false
    t.boolean "equipable", default: false
    t.integer "emeraldcost", default: 0
    t.integer "cost"
    t.datetime "created_on"
    t.datetime "reviewed_on"
    t.datetime "updated_on"
    t.integer "user_id"
    t.integer "itemtype_id"
    t.boolean "reviewed", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "itemtypes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_on"
    t.integer "basecost"
    t.integer "dreyterriumcost"
    t.boolean "demoitem", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "jukeboxes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "ogg"
    t.string "mp3"
    t.datetime "created_on"
    t.datetime "updated_on"
    t.integer "user_id"
    t.integer "bookgroup_id"
    t.integer "gviewer_id"
    t.boolean "music_on", default: false
    t.boolean "privatejukebox", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "mainfolders", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_on"
    t.datetime "updated_on"
    t.integer "user_id"
    t.integer "gallery_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "mainplaylists", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_on"
    t.datetime "updated_on"
    t.integer "user_id"
    t.integer "channel_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "mainsheets", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_on"
    t.datetime "updated_on"
    t.integer "user_id"
    t.integer "jukebox_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "maintenancemodes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_on"
    t.boolean "maintenance_on", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "monsterbattles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "partner_plevel"
    t.integer "partner_pexp"
    t.integer "partner_chp"
    t.integer "partner_hp"
    t.integer "partner_atk"
    t.integer "partner_def"
    t.integer "partner_agility"
    t.integer "partner_strength"
    t.integer "partner_mlevel"
    t.integer "partner_mexp"
    t.integer "partner_cmp"
    t.integer "partner_mp"
    t.integer "partner_matk"
    t.integer "partner_mdef"
    t.integer "partner_magi"
    t.integer "partner_mstr"
    t.integer "partner_lives"
    t.integer "partner_damage", default: 0
    t.boolean "partner_activepet", default: false
    t.integer "creaturetype_id"
    t.string "monster_mischief"
    t.integer "monster_plevel"
    t.integer "monster_chp"
    t.integer "monster_hp"
    t.integer "monster_atk"
    t.integer "monster_def"
    t.integer "monster_agility"
    t.integer "monster_mlevel"
    t.integer "monster_cmp"
    t.integer "monster_mp"
    t.integer "monster_matk"
    t.integer "monster_mdef"
    t.integer "monster_magi"
    t.integer "monster_loot"
    t.integer "monster_damage", default: 0
    t.integer "monstertype_id"
    t.integer "round", default: 0
    t.integer "tokens_earned", default: 0
    t.integer "exp_earned", default: 0
    t.integer "dreyore_earned", default: 0
    t.integer "items_earned", default: 0
    t.boolean "battleover", default: false
    t.string "battleresult", default: "Not-Started"
    t.datetime "started_on"
    t.datetime "ended_on"
    t.integer "fight_id"
    t.integer "monster_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "monsters", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "image"
    t.string "ogg"
    t.string "mp3"
    t.integer "level", default: 0
    t.integer "hp", default: 0
    t.integer "atk", default: 0
    t.integer "def", default: 0
    t.integer "agility", default: 0
    t.integer "mp", default: 0
    t.integer "matk", default: 0
    t.integer "mdef", default: 0
    t.integer "magi", default: 0
    t.integer "exp", default: 0
    t.integer "loot", default: 0
    t.string "mischief"
    t.integer "nightmare", default: 0
    t.integer "shinycraze", default: 0
    t.integer "party", default: 0
    t.integer "rarity", default: 1
    t.boolean "retiredmonster", default: false
    t.integer "cost", default: 0
    t.datetime "created_on"
    t.datetime "updated_on"
    t.datetime "reviewed_on"
    t.integer "user_id"
    t.integer "monstertype_id"
    t.integer "element_id"
    t.boolean "reviewed", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "monstertypes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_on"
    t.integer "basecost"
    t.integer "emeraldcost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "movies", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "ogv"
    t.string "mp4"
    t.datetime "created_on"
    t.datetime "updated_on"
    t.datetime "reviewed_on"
    t.integer "user_id"
    t.integer "bookgroup_id"
    t.integer "subplaylist_id"
    t.boolean "reviewed", default: false
    t.boolean "pointsreceived", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "movietags", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "movie_id"
    t.integer "tag1_id"
    t.integer "tag2_id"
    t.integer "tag3_id"
    t.integer "tag4_id"
    t.integer "tag5_id"
    t.integer "tag6_id"
    t.integer "tag7_id"
    t.integer "tag8_id"
    t.integer "tag9_id"
    t.integer "tag10_id"
    t.integer "tag11_id"
    t.integer "tag12_id"
    t.integer "tag13_id"
    t.integer "tag14_id"
    t.integer "tag15_id"
    t.integer "tag16_id"
    t.integer "tag17_id"
    t.integer "tag18_id"
    t.integer "tag19_id"
    t.integer "tag20_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ocs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "nickname"
    t.string "species"
    t.integer "age"
    t.text "personality"
    t.text "likesanddislikes"
    t.text "backgroundandhistory"
    t.text "relatives"
    t.text "family"
    t.text "friends"
    t.text "world"
    t.string "alignment"
    t.text "alliance"
    t.text "elements"
    t.text "appearance"
    t.text "clothing"
    t.text "accessories"
    t.string "image"
    t.string "ogg"
    t.string "mp3"
    t.string "voiceogg"
    t.string "voicemp3"
    t.datetime "created_on"
    t.datetime "updated_on"
    t.datetime "reviewed_on"
    t.boolean "reviewed", default: false
    t.boolean "pointsreceived", default: false
    t.integer "user_id"
    t.integer "bookgroup_id"
    t.integer "gviewer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "octags", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "oc_id"
    t.integer "tag1_id"
    t.integer "tag2_id"
    t.integer "tag3_id"
    t.integer "tag4_id"
    t.integer "tag5_id"
    t.integer "tag6_id"
    t.integer "tag7_id"
    t.integer "tag8_id"
    t.integer "tag9_id"
    t.integer "tag10_id"
    t.integer "tag11_id"
    t.integer "tag12_id"
    t.integer "tag13_id"
    t.integer "tag14_id"
    t.integer "tag15_id"
    t.integer "tag16_id"
    t.integer "tag17_id"
    t.integer "tag18_id"
    t.integer "tag19_id"
    t.integer "tag20_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "partners", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "plevel"
    t.integer "pexp", default: 0
    t.integer "chp"
    t.integer "hp"
    t.integer "atk"
    t.integer "def"
    t.integer "agility"
    t.integer "strength"
    t.integer "mlevel"
    t.integer "mexp", default: 0
    t.integer "cmp"
    t.integer "mp"
    t.integer "matk"
    t.integer "mdef"
    t.integer "magi"
    t.integer "mstr"
    t.integer "chunger"
    t.integer "hunger"
    t.integer "cthirst"
    t.integer "thirst"
    t.integer "cfun"
    t.integer "fun"
    t.integer "lives"
    t.integer "adoptcost"
    t.integer "cost"
    t.integer "phytokens", default: 0
    t.integer "magitokens", default: 0
    t.datetime "adopted_on"
    t.datetime "updated_on"
    t.integer "user_id"
    t.integer "creature_id"
    t.boolean "activepet", default: false
    t.boolean "inbattle", default: false
    t.boolean "dead", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pmboxes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "capacity"
    t.boolean "box_open", default: false
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pmreplies", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "message"
    t.string "image"
    t.string "ogg"
    t.string "mp3"
    t.string "ogv"
    t.string "mp4"
    t.datetime "created_on"
    t.datetime "updated_on"
    t.integer "user_id"
    t.integer "pm_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pms", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.text "message"
    t.string "image"
    t.string "ogg"
    t.string "mp3"
    t.string "ogv"
    t.string "mp4"
    t.datetime "created_on"
    t.datetime "updated_on"
    t.boolean "user1_unread", default: false
    t.boolean "user2_unread", default: false
    t.integer "user_id"
    t.integer "pmbox_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pouches", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "user_id"
    t.string "privilege", default: "User"
    t.boolean "admin", default: false
    t.boolean "demouser", default: false
    t.boolean "banned", default: false
    t.string "remember_token"
    t.datetime "expiretime"
    t.boolean "activated", default: false
    t.datetime "signed_in_at"
    t.datetime "last_visited"
    t.datetime "signed_out_at"
    t.boolean "gone", default: false
    t.integer "amount", default: 0
    t.integer "emeraldamount", default: 0
    t.integer "dreyoreamount", default: 0
    t.boolean "firstdreyore", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pouchslots", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "pouchtype1_id", default: 1
    t.integer "free1", default: 0
    t.integer "member1", default: 0
    t.integer "pouchtype2_id", default: 1
    t.integer "free2", default: 0
    t.integer "member2", default: 0
    t.integer "pouchtype3_id", default: 1
    t.integer "free3", default: 0
    t.integer "member3", default: 0
    t.integer "pouchtype4_id", default: 1
    t.integer "free4", default: 0
    t.integer "member4", default: 0
    t.integer "pouchtype5_id", default: 1
    t.integer "free5", default: 0
    t.integer "member5", default: 0
    t.integer "pouchtype6_id", default: 1
    t.integer "free6", default: 0
    t.integer "member6", default: 0
    t.integer "pouchtype7_id", default: 1
    t.integer "free7", default: 0
    t.integer "member7", default: 0
    t.integer "pouchtype8_id", default: 1
    t.integer "free8", default: 0
    t.integer "member8", default: 0
    t.integer "pouchtype9_id", default: 1
    t.integer "free9", default: 0
    t.integer "member9", default: 0
    t.integer "pouchtype10_id", default: 1
    t.integer "free10", default: 0
    t.integer "member10", default: 0
    t.integer "pouchtype11_id", default: 1
    t.integer "free11", default: 0
    t.integer "member11", default: 0
    t.integer "pouchtype12_id", default: 1
    t.integer "free12", default: 0
    t.integer "member12", default: 0
    t.integer "pouchtype13_id", default: 1
    t.integer "free13", default: 0
    t.integer "member13", default: 0
    t.integer "pouchtype14_id", default: 1
    t.integer "free14", default: 0
    t.integer "member14", default: 0
    t.integer "pouchtype15_id", default: 1
    t.integer "free15", default: 0
    t.integer "member15", default: 0
    t.integer "pouchtype16_id", default: 1
    t.integer "free16", default: 0
    t.integer "member16", default: 0
    t.integer "pouchtype17_id", default: 1
    t.integer "free17", default: 0
    t.integer "member17", default: 0
    t.integer "pouchtype18_id", default: 1
    t.integer "free18", default: 0
    t.integer "member18", default: 0
    t.integer "pouchtype19_id", default: 1
    t.integer "free19", default: 0
    t.integer "member19", default: 0
    t.integer "pouchtype20_id", default: 1
    t.integer "free20", default: 0
    t.integer "member20", default: 0
    t.integer "pouchtype21_id", default: 1
    t.integer "free21", default: 0
    t.integer "member21", default: 0
    t.integer "pouchtype22_id", default: 1
    t.integer "free22", default: 0
    t.integer "member22", default: 0
    t.integer "pouchtype23_id", default: 1
    t.integer "free23", default: 0
    t.integer "member23", default: 0
    t.integer "pouchtype24_id", default: 1
    t.integer "free24", default: 0
    t.integer "member24", default: 0
    t.integer "pouchtype25_id", default: 1
    t.integer "free25", default: 0
    t.integer "member25", default: 0
    t.integer "pouchtype26_id", default: 1
    t.integer "free26", default: 0
    t.integer "member26", default: 0
    t.integer "pouchtype27_id", default: 1
    t.integer "free27", default: 0
    t.integer "member27", default: 0
    t.integer "pouchtype28_id", default: 1
    t.integer "free28", default: 0
    t.integer "member28", default: 0
    t.integer "pouchtype29_id", default: 1
    t.integer "free29", default: 0
    t.integer "member29", default: 0
    t.integer "pouchtype30_id", default: 1
    t.integer "free30", default: 0
    t.integer "member30", default: 0
    t.integer "pouchtype31_id", default: 1
    t.integer "free31", default: 0
    t.integer "member31", default: 0
    t.integer "pouchtype32_id", default: 1
    t.integer "free32", default: 0
    t.integer "member32", default: 0
    t.integer "pouchtype33_id", default: 1
    t.integer "free33", default: 0
    t.integer "member33", default: 0
    t.integer "pouchtype34_id", default: 1
    t.integer "free34", default: 0
    t.integer "member34", default: 0
    t.integer "pouchtype35_id", default: 1
    t.integer "free35", default: 0
    t.integer "member35", default: 0
    t.integer "pouchtype36_id", default: 1
    t.integer "free36", default: 0
    t.integer "member36", default: 0
    t.integer "pouchtype37_id", default: 1
    t.integer "free37", default: 0
    t.integer "member37", default: 0
    t.integer "pouchtype38_id", default: 1
    t.integer "free38", default: 0
    t.integer "member38", default: 0
    t.integer "pouchtype39_id", default: 1
    t.integer "free39", default: 0
    t.integer "member39", default: 0
    t.integer "pouchtype40_id", default: 1
    t.integer "free40", default: 0
    t.integer "member40", default: 0
    t.integer "pouchtype41_id", default: 1
    t.integer "free41", default: 0
    t.integer "member41", default: 0
    t.integer "pouchtype42_id", default: 1
    t.integer "free42", default: 0
    t.integer "member42", default: 0
    t.integer "pouch_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pouchtypes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_on"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ratecosts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.float "amount", limit: 53
    t.string "econtype"
    t.datetime "created_on"
    t.datetime "updated_on"
    t.integer "baserate_id"
    t.integer "dragonhoard_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "referrals", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.datetime "created_on"
    t.integer "user_id"
    t.integer "referred_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "registrations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "imaginaryfriend"
    t.string "email"
    t.string "country"
    t.string "country_timezone"
    t.date "birthday"
    t.text "message"
    t.boolean "shared", default: false
    t.string "login_id"
    t.string "vname"
    t.datetime "registered_on"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "regtokens", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "token"
    t.datetime "expiretime"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shoutboxes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "capacity"
    t.boolean "box_open", default: false
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shouts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "message"
    t.datetime "created_on"
    t.datetime "updated_on"
    t.datetime "reviewed_on"
    t.integer "user_id"
    t.integer "shoutbox_id"
    t.boolean "reviewed", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sounds", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "ogg"
    t.string "mp3"
    t.datetime "created_on"
    t.datetime "updated_on"
    t.datetime "reviewed_on"
    t.integer "user_id"
    t.integer "bookgroup_id"
    t.integer "subsheet_id"
    t.boolean "reviewed", default: false
    t.boolean "pointsreceived", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "soundtags", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "sound_id"
    t.integer "tag1_id"
    t.integer "tag2_id"
    t.integer "tag3_id"
    t.integer "tag4_id"
    t.integer "tag5_id"
    t.integer "tag6_id"
    t.integer "tag7_id"
    t.integer "tag8_id"
    t.integer "tag9_id"
    t.integer "tag10_id"
    t.integer "tag11_id"
    t.integer "tag12_id"
    t.integer "tag13_id"
    t.integer "tag14_id"
    t.integer "tag15_id"
    t.integer "tag16_id"
    t.integer "tag17_id"
    t.integer "tag18_id"
    t.integer "tag19_id"
    t.integer "tag20_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subfolders", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_on"
    t.datetime "updated_on"
    t.integer "user_id"
    t.integer "mainfolder_id"
    t.boolean "collab_mode", default: false
    t.boolean "fave_folder", default: false
    t.boolean "privatesubfolder", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subplaylists", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_on"
    t.datetime "updated_on"
    t.integer "user_id"
    t.integer "mainplaylist_id"
    t.boolean "collab_mode", default: false
    t.boolean "fave_folder", default: false
    t.boolean "privatesubplaylist", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subsheets", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_on"
    t.datetime "updated_on"
    t.integer "user_id"
    t.integer "mainsheet_id"
    t.boolean "collab_mode", default: false
    t.boolean "fave_folder", default: false
    t.boolean "privatesubsheet", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "suggestions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_on"
    t.datetime "updated_on"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "suspendedtimelimits", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "pointfines", default: 0
    t.integer "emeraldfines", default: 0
    t.datetime "timelimit"
    t.text "reason"
    t.datetime "created_on"
    t.integer "user_id"
    t.integer "from_user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tags", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_on"
    t.datetime "updated_on"
    t.integer "bookgroup_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "userinfos", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "avatar"
    t.string "miniavatar"
    t.string "mp3"
    t.string "ogg"
    t.boolean "nightvision", default: false
    t.boolean "music_on", default: false
    t.boolean "mute_on", default: false
    t.string "audiobrowser", default: "ogg"
    t.string "videobrowser", default: "ogv"
    t.boolean "militarytime", default: false
    t.integer "bookgroup_id"
    t.text "info"
    t.integer "user_id"
    t.integer "daycolor_id"
    t.integer "nightcolor_id"
    t.boolean "admincontrols_on", default: false
    t.boolean "reviewercontrols_on", default: false
    t.boolean "keymastercontrols_on", default: false
    t.boolean "managercontrols_on", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "imaginaryfriend"
    t.string "email"
    t.string "country"
    t.string "country_timezone"
    t.date "birthday"
    t.string "login_id"
    t.string "vname"
    t.boolean "shared", default: false
    t.datetime "joined_on"
    t.datetime "registered_on"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "userupgrades", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.integer "base"
    t.integer "baseinc"
    t.integer "price"
    t.integer "freecap"
    t.integer "membercap"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "warehouses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.text "message"
    t.string "ogg"
    t.string "mp3"
    t.datetime "created_on"
    t.datetime "updated_on"
    t.integer "treasury", default: 0
    t.integer "profit", default: 0
    t.integer "hoardpoints", default: 0
    t.integer "emeralds", default: 0
    t.boolean "store_open", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "webcontrols", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.datetime "created_on"
    t.string "banner"
    t.string "mascot"
    t.string "favicon"
    t.integer "daycolor_id"
    t.integer "nightcolor_id"
    t.string "ogg"
    t.string "mp3"
    t.string "criticalogg"
    t.string "criticalmp3"
    t.string "betaogg"
    t.string "betamp3"
    t.string "grandogg"
    t.string "grandmp3"
    t.string "creationogg"
    t.string "creationmp3"
    t.string "maintenanceogg"
    t.string "maintenancemp3"
    t.string "missingpageogg"
    t.string "missingpagemp3"
    t.boolean "gate_open", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "witemshelves", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.integer "warehouse_id"
    t.integer "item1_id"
    t.integer "qty1", default: 0
    t.integer "tax1", default: 0
    t.integer "item2_id"
    t.integer "qty2", default: 0
    t.integer "tax2", default: 0
    t.integer "item3_id"
    t.integer "qty3", default: 0
    t.integer "tax3", default: 0
    t.integer "item4_id"
    t.integer "qty4", default: 0
    t.integer "tax4", default: 0
    t.integer "item5_id"
    t.integer "qty5", default: 0
    t.integer "tax5", default: 0
    t.integer "item6_id"
    t.integer "qty6", default: 0
    t.integer "tax6", default: 0
    t.integer "item7_id"
    t.integer "qty7", default: 0
    t.integer "tax7", default: 0
    t.integer "item8_id"
    t.integer "qty8", default: 0
    t.integer "tax8", default: 0
    t.integer "item9_id"
    t.integer "qty9", default: 0
    t.integer "tax9", default: 0
    t.integer "item10_id"
    t.integer "qty10", default: 0
    t.integer "tax10", default: 0
    t.integer "item11_id"
    t.integer "qty11", default: 0
    t.integer "tax11", default: 0
    t.integer "item12_id"
    t.integer "qty12", default: 0
    t.integer "tax12", default: 0
    t.integer "item13_id"
    t.integer "qty13", default: 0
    t.integer "tax13", default: 0
    t.integer "item14_id"
    t.integer "qty14", default: 0
    t.integer "tax14", default: 0
    t.integer "item15_id"
    t.integer "qty15", default: 0
    t.integer "tax15", default: 0
    t.integer "item16_id"
    t.integer "qty16", default: 0
    t.integer "tax16", default: 0
    t.integer "item17_id"
    t.integer "qty17", default: 0
    t.integer "tax17", default: 0
    t.integer "item18_id"
    t.integer "qty18", default: 0
    t.integer "tax18", default: 0
    t.integer "item19_id"
    t.integer "qty19", default: 0
    t.integer "tax19", default: 0
    t.integer "item20_id"
    t.integer "qty20", default: 0
    t.integer "tax20", default: 0
    t.integer "item21_id"
    t.integer "qty21", default: 0
    t.integer "tax21", default: 0
    t.integer "item22_id"
    t.integer "qty22", default: 0
    t.integer "tax22", default: 0
    t.integer "item23_id"
    t.integer "qty23", default: 0
    t.integer "tax23", default: 0
    t.integer "item24_id"
    t.integer "qty24", default: 0
    t.integer "tax24", default: 0
    t.integer "item25_id"
    t.integer "qty25", default: 0
    t.integer "tax25", default: 0
    t.integer "item26_id"
    t.integer "qty26", default: 0
    t.integer "tax26", default: 0
    t.integer "item27_id"
    t.integer "qty27", default: 0
    t.integer "tax27", default: 0
    t.integer "item28_id"
    t.integer "qty28", default: 0
    t.integer "tax28", default: 0
    t.integer "item29_id"
    t.integer "qty29", default: 0
    t.integer "tax29", default: 0
    t.integer "item30_id"
    t.integer "qty30", default: 0
    t.integer "tax30", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "wpetdens", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.integer "warehouse_id"
    t.integer "creature1_id"
    t.integer "qty1", default: 0
    t.integer "tax1", default: 0
    t.integer "creature2_id"
    t.integer "qty2", default: 0
    t.integer "tax2", default: 0
    t.integer "creature3_id"
    t.integer "qty3", default: 0
    t.integer "tax3", default: 0
    t.integer "creature4_id"
    t.integer "qty4", default: 0
    t.integer "tax4", default: 0
    t.integer "creature5_id"
    t.integer "qty5", default: 0
    t.integer "tax5", default: 0
    t.integer "creature6_id"
    t.integer "qty6", default: 0
    t.integer "tax6", default: 0
    t.integer "creature7_id"
    t.integer "qty7", default: 0
    t.integer "tax7", default: 0
    t.integer "creature8_id"
    t.integer "qty8", default: 0
    t.integer "tax8", default: 0
    t.integer "creature9_id"
    t.integer "qty9", default: 0
    t.integer "tax9", default: 0
    t.integer "creature10_id"
    t.integer "qty10", default: 0
    t.integer "tax10", default: 0
    t.integer "creature11_id"
    t.integer "qty11", default: 0
    t.integer "tax11", default: 0
    t.integer "creature12_id"
    t.integer "qty12", default: 0
    t.integer "tax12", default: 0
    t.integer "creature13_id"
    t.integer "qty13", default: 0
    t.integer "tax13", default: 0
    t.integer "creature14_id"
    t.integer "qty14", default: 0
    t.integer "tax14", default: 0
    t.integer "creature15_id"
    t.integer "qty15", default: 0
    t.integer "tax15", default: 0
    t.integer "creature16_id"
    t.integer "qty16", default: 0
    t.integer "tax16", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
