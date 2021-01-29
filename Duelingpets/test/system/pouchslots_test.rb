require "application_system_test_case"

class PouchslotsTest < ApplicationSystemTestCase
  setup do
    @pouchslot = pouchslots(:one)
  end

  test "visiting the index" do
    visit pouchslots_url
    assert_selector "h1", text: "Pouchslots"
  end

  test "creating a Pouchslot" do
    visit pouchslots_url
    click_on "New Pouchslot"

    fill_in "Free1", with: @pouchslot.free1
    fill_in "Free10", with: @pouchslot.free10
    fill_in "Free11", with: @pouchslot.free11
    fill_in "Free12", with: @pouchslot.free12
    fill_in "Free13", with: @pouchslot.free13
    fill_in "Free14", with: @pouchslot.free14
    fill_in "Free15", with: @pouchslot.free15
    fill_in "Free16", with: @pouchslot.free16
    fill_in "Free17", with: @pouchslot.free17
    fill_in "Free18", with: @pouchslot.free18
    fill_in "Free19", with: @pouchslot.free19
    fill_in "Free2", with: @pouchslot.free2
    fill_in "Free20", with: @pouchslot.free20
    fill_in "Free21", with: @pouchslot.free21
    fill_in "Free22", with: @pouchslot.free22
    fill_in "Free23", with: @pouchslot.free23
    fill_in "Free24", with: @pouchslot.free24
    fill_in "Free25", with: @pouchslot.free25
    fill_in "Free26", with: @pouchslot.free26
    fill_in "Free27", with: @pouchslot.free27
    fill_in "Free28", with: @pouchslot.free28
    fill_in "Free29", with: @pouchslot.free29
    fill_in "Free3", with: @pouchslot.free3
    fill_in "Free30", with: @pouchslot.free30
    fill_in "Free31", with: @pouchslot.free31
    fill_in "Free32", with: @pouchslot.free32
    fill_in "Free33", with: @pouchslot.free33
    fill_in "Free34", with: @pouchslot.free34
    fill_in "Free35", with: @pouchslot.free35
    fill_in "Free36", with: @pouchslot.free36
    fill_in "Free37", with: @pouchslot.free37
    fill_in "Free38", with: @pouchslot.free38
    fill_in "Free39", with: @pouchslot.free39
    fill_in "Free4", with: @pouchslot.free4
    fill_in "Free40", with: @pouchslot.free40
    fill_in "Free41", with: @pouchslot.free41
    fill_in "Free42", with: @pouchslot.free42
    fill_in "Free5", with: @pouchslot.free5
    fill_in "Free6", with: @pouchslot.free6
    fill_in "Free7", with: @pouchslot.free7
    fill_in "Free8", with: @pouchslot.free8
    fill_in "Free9", with: @pouchslot.free9
    fill_in "Member1", with: @pouchslot.member1
    fill_in "Member10", with: @pouchslot.member10
    fill_in "Member11", with: @pouchslot.member11
    fill_in "Member12", with: @pouchslot.member12
    fill_in "Member13", with: @pouchslot.member13
    fill_in "Member14", with: @pouchslot.member14
    fill_in "Member15", with: @pouchslot.member15
    fill_in "Member16", with: @pouchslot.member16
    fill_in "Member17", with: @pouchslot.member17
    fill_in "Member18", with: @pouchslot.member18
    fill_in "Member19", with: @pouchslot.member19
    fill_in "Member2", with: @pouchslot.member2
    fill_in "Member20", with: @pouchslot.member20
    fill_in "Member21", with: @pouchslot.member21
    fill_in "Member22", with: @pouchslot.member22
    fill_in "Member23", with: @pouchslot.member23
    fill_in "Member24", with: @pouchslot.member24
    fill_in "Member25", with: @pouchslot.member25
    fill_in "Member26", with: @pouchslot.member26
    fill_in "Member27", with: @pouchslot.member27
    fill_in "Member28", with: @pouchslot.member28
    fill_in "Member29", with: @pouchslot.member29
    fill_in "Member3", with: @pouchslot.member3
    fill_in "Member30", with: @pouchslot.member30
    fill_in "Member31", with: @pouchslot.member31
    fill_in "Member32", with: @pouchslot.member32
    fill_in "Member33", with: @pouchslot.member33
    fill_in "Member34", with: @pouchslot.member34
    fill_in "Member35", with: @pouchslot.member35
    fill_in "Member36", with: @pouchslot.member36
    fill_in "Member37", with: @pouchslot.member37
    fill_in "Member38", with: @pouchslot.member38
    fill_in "Member39", with: @pouchslot.member39
    fill_in "Member4", with: @pouchslot.member4
    fill_in "Member40", with: @pouchslot.member40
    fill_in "Member41", with: @pouchslot.member41
    fill_in "Member42", with: @pouchslot.member42
    fill_in "Member5", with: @pouchslot.member5
    fill_in "Member6", with: @pouchslot.member6
    fill_in "Member7", with: @pouchslot.member7
    fill_in "Member8", with: @pouchslot.member8
    fill_in "Member9", with: @pouchslot.member9
    fill_in "Pouch", with: @pouchslot.pouch_id
    fill_in "Pouchtype10", with: @pouchslot.pouchtype10_id
    fill_in "Pouchtype11", with: @pouchslot.pouchtype11_id
    fill_in "Pouchtype12", with: @pouchslot.pouchtype12_id
    fill_in "Pouchtype13", with: @pouchslot.pouchtype13_id
    fill_in "Pouchtype14", with: @pouchslot.pouchtype14_id
    fill_in "Pouchtype15", with: @pouchslot.pouchtype15_id
    fill_in "Pouchtype16", with: @pouchslot.pouchtype16_id
    fill_in "Pouchtype17", with: @pouchslot.pouchtype17_id
    fill_in "Pouchtype18", with: @pouchslot.pouchtype18_id
    fill_in "Pouchtype19", with: @pouchslot.pouchtype19_id
    fill_in "Pouchtype1", with: @pouchslot.pouchtype1_id
    fill_in "Pouchtype20", with: @pouchslot.pouchtype20_id
    fill_in "Pouchtype21", with: @pouchslot.pouchtype21_id
    fill_in "Pouchtype22", with: @pouchslot.pouchtype22_id
    fill_in "Pouchtype23", with: @pouchslot.pouchtype23_id
    fill_in "Pouchtype24", with: @pouchslot.pouchtype24_id
    fill_in "Pouchtype25", with: @pouchslot.pouchtype25_id
    fill_in "Pouchtype26", with: @pouchslot.pouchtype26_id
    fill_in "Pouchtype27", with: @pouchslot.pouchtype27_id
    fill_in "Pouchtype28", with: @pouchslot.pouchtype28_id
    fill_in "Pouchtype29", with: @pouchslot.pouchtype29_id
    fill_in "Pouchtype2", with: @pouchslot.pouchtype2_id
    fill_in "Pouchtype30", with: @pouchslot.pouchtype30_id
    fill_in "Pouchtype31", with: @pouchslot.pouchtype31_id
    fill_in "Pouchtype32", with: @pouchslot.pouchtype32_id
    fill_in "Pouchtype33", with: @pouchslot.pouchtype33_id
    fill_in "Pouchtype34", with: @pouchslot.pouchtype34_id
    fill_in "Pouchtype35", with: @pouchslot.pouchtype35_id
    fill_in "Pouchtype36", with: @pouchslot.pouchtype36_id
    fill_in "Pouchtype37", with: @pouchslot.pouchtype37_id
    fill_in "Pouchtype38", with: @pouchslot.pouchtype38_id
    fill_in "Pouchtype39", with: @pouchslot.pouchtype39_id
    fill_in "Pouchtype3", with: @pouchslot.pouchtype3_id
    fill_in "Pouchtype40", with: @pouchslot.pouchtype40_id
    fill_in "Pouchtype41", with: @pouchslot.pouchtype41_id
    fill_in "Pouchtype42", with: @pouchslot.pouchtype42_id
    fill_in "Pouchtype4", with: @pouchslot.pouchtype4_id
    fill_in "Pouchtype5", with: @pouchslot.pouchtype5_id
    fill_in "Pouchtype6", with: @pouchslot.pouchtype6_id
    fill_in "Pouchtype7", with: @pouchslot.pouchtype7_id
    fill_in "Pouchtype8", with: @pouchslot.pouchtype8_id
    fill_in "Pouchtype9", with: @pouchslot.pouchtype9_id
    click_on "Create Pouchslot"

    assert_text "Pouchslot was successfully created"
    click_on "Back"
  end

  test "updating a Pouchslot" do
    visit pouchslots_url
    click_on "Edit", match: :first

    fill_in "Free1", with: @pouchslot.free1
    fill_in "Free10", with: @pouchslot.free10
    fill_in "Free11", with: @pouchslot.free11
    fill_in "Free12", with: @pouchslot.free12
    fill_in "Free13", with: @pouchslot.free13
    fill_in "Free14", with: @pouchslot.free14
    fill_in "Free15", with: @pouchslot.free15
    fill_in "Free16", with: @pouchslot.free16
    fill_in "Free17", with: @pouchslot.free17
    fill_in "Free18", with: @pouchslot.free18
    fill_in "Free19", with: @pouchslot.free19
    fill_in "Free2", with: @pouchslot.free2
    fill_in "Free20", with: @pouchslot.free20
    fill_in "Free21", with: @pouchslot.free21
    fill_in "Free22", with: @pouchslot.free22
    fill_in "Free23", with: @pouchslot.free23
    fill_in "Free24", with: @pouchslot.free24
    fill_in "Free25", with: @pouchslot.free25
    fill_in "Free26", with: @pouchslot.free26
    fill_in "Free27", with: @pouchslot.free27
    fill_in "Free28", with: @pouchslot.free28
    fill_in "Free29", with: @pouchslot.free29
    fill_in "Free3", with: @pouchslot.free3
    fill_in "Free30", with: @pouchslot.free30
    fill_in "Free31", with: @pouchslot.free31
    fill_in "Free32", with: @pouchslot.free32
    fill_in "Free33", with: @pouchslot.free33
    fill_in "Free34", with: @pouchslot.free34
    fill_in "Free35", with: @pouchslot.free35
    fill_in "Free36", with: @pouchslot.free36
    fill_in "Free37", with: @pouchslot.free37
    fill_in "Free38", with: @pouchslot.free38
    fill_in "Free39", with: @pouchslot.free39
    fill_in "Free4", with: @pouchslot.free4
    fill_in "Free40", with: @pouchslot.free40
    fill_in "Free41", with: @pouchslot.free41
    fill_in "Free42", with: @pouchslot.free42
    fill_in "Free5", with: @pouchslot.free5
    fill_in "Free6", with: @pouchslot.free6
    fill_in "Free7", with: @pouchslot.free7
    fill_in "Free8", with: @pouchslot.free8
    fill_in "Free9", with: @pouchslot.free9
    fill_in "Member1", with: @pouchslot.member1
    fill_in "Member10", with: @pouchslot.member10
    fill_in "Member11", with: @pouchslot.member11
    fill_in "Member12", with: @pouchslot.member12
    fill_in "Member13", with: @pouchslot.member13
    fill_in "Member14", with: @pouchslot.member14
    fill_in "Member15", with: @pouchslot.member15
    fill_in "Member16", with: @pouchslot.member16
    fill_in "Member17", with: @pouchslot.member17
    fill_in "Member18", with: @pouchslot.member18
    fill_in "Member19", with: @pouchslot.member19
    fill_in "Member2", with: @pouchslot.member2
    fill_in "Member20", with: @pouchslot.member20
    fill_in "Member21", with: @pouchslot.member21
    fill_in "Member22", with: @pouchslot.member22
    fill_in "Member23", with: @pouchslot.member23
    fill_in "Member24", with: @pouchslot.member24
    fill_in "Member25", with: @pouchslot.member25
    fill_in "Member26", with: @pouchslot.member26
    fill_in "Member27", with: @pouchslot.member27
    fill_in "Member28", with: @pouchslot.member28
    fill_in "Member29", with: @pouchslot.member29
    fill_in "Member3", with: @pouchslot.member3
    fill_in "Member30", with: @pouchslot.member30
    fill_in "Member31", with: @pouchslot.member31
    fill_in "Member32", with: @pouchslot.member32
    fill_in "Member33", with: @pouchslot.member33
    fill_in "Member34", with: @pouchslot.member34
    fill_in "Member35", with: @pouchslot.member35
    fill_in "Member36", with: @pouchslot.member36
    fill_in "Member37", with: @pouchslot.member37
    fill_in "Member38", with: @pouchslot.member38
    fill_in "Member39", with: @pouchslot.member39
    fill_in "Member4", with: @pouchslot.member4
    fill_in "Member40", with: @pouchslot.member40
    fill_in "Member41", with: @pouchslot.member41
    fill_in "Member42", with: @pouchslot.member42
    fill_in "Member5", with: @pouchslot.member5
    fill_in "Member6", with: @pouchslot.member6
    fill_in "Member7", with: @pouchslot.member7
    fill_in "Member8", with: @pouchslot.member8
    fill_in "Member9", with: @pouchslot.member9
    fill_in "Pouch", with: @pouchslot.pouch_id
    fill_in "Pouchtype10", with: @pouchslot.pouchtype10_id
    fill_in "Pouchtype11", with: @pouchslot.pouchtype11_id
    fill_in "Pouchtype12", with: @pouchslot.pouchtype12_id
    fill_in "Pouchtype13", with: @pouchslot.pouchtype13_id
    fill_in "Pouchtype14", with: @pouchslot.pouchtype14_id
    fill_in "Pouchtype15", with: @pouchslot.pouchtype15_id
    fill_in "Pouchtype16", with: @pouchslot.pouchtype16_id
    fill_in "Pouchtype17", with: @pouchslot.pouchtype17_id
    fill_in "Pouchtype18", with: @pouchslot.pouchtype18_id
    fill_in "Pouchtype19", with: @pouchslot.pouchtype19_id
    fill_in "Pouchtype1", with: @pouchslot.pouchtype1_id
    fill_in "Pouchtype20", with: @pouchslot.pouchtype20_id
    fill_in "Pouchtype21", with: @pouchslot.pouchtype21_id
    fill_in "Pouchtype22", with: @pouchslot.pouchtype22_id
    fill_in "Pouchtype23", with: @pouchslot.pouchtype23_id
    fill_in "Pouchtype24", with: @pouchslot.pouchtype24_id
    fill_in "Pouchtype25", with: @pouchslot.pouchtype25_id
    fill_in "Pouchtype26", with: @pouchslot.pouchtype26_id
    fill_in "Pouchtype27", with: @pouchslot.pouchtype27_id
    fill_in "Pouchtype28", with: @pouchslot.pouchtype28_id
    fill_in "Pouchtype29", with: @pouchslot.pouchtype29_id
    fill_in "Pouchtype2", with: @pouchslot.pouchtype2_id
    fill_in "Pouchtype30", with: @pouchslot.pouchtype30_id
    fill_in "Pouchtype31", with: @pouchslot.pouchtype31_id
    fill_in "Pouchtype32", with: @pouchslot.pouchtype32_id
    fill_in "Pouchtype33", with: @pouchslot.pouchtype33_id
    fill_in "Pouchtype34", with: @pouchslot.pouchtype34_id
    fill_in "Pouchtype35", with: @pouchslot.pouchtype35_id
    fill_in "Pouchtype36", with: @pouchslot.pouchtype36_id
    fill_in "Pouchtype37", with: @pouchslot.pouchtype37_id
    fill_in "Pouchtype38", with: @pouchslot.pouchtype38_id
    fill_in "Pouchtype39", with: @pouchslot.pouchtype39_id
    fill_in "Pouchtype3", with: @pouchslot.pouchtype3_id
    fill_in "Pouchtype40", with: @pouchslot.pouchtype40_id
    fill_in "Pouchtype41", with: @pouchslot.pouchtype41_id
    fill_in "Pouchtype42", with: @pouchslot.pouchtype42_id
    fill_in "Pouchtype4", with: @pouchslot.pouchtype4_id
    fill_in "Pouchtype5", with: @pouchslot.pouchtype5_id
    fill_in "Pouchtype6", with: @pouchslot.pouchtype6_id
    fill_in "Pouchtype7", with: @pouchslot.pouchtype7_id
    fill_in "Pouchtype8", with: @pouchslot.pouchtype8_id
    fill_in "Pouchtype9", with: @pouchslot.pouchtype9_id
    click_on "Update Pouchslot"

    assert_text "Pouchslot was successfully updated"
    click_on "Back"
  end

  test "destroying a Pouchslot" do
    visit pouchslots_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Pouchslot was successfully destroyed"
  end
end
