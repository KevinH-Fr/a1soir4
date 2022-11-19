require "application_system_test_case"

class AvoirrembsTest < ApplicationSystemTestCase
  setup do
    @avoirremb = avoirrembs(:one)
  end

  test "visiting the index" do
    visit avoirrembs_url
    assert_selector "h1", text: "Avoirrembs"
  end

  test "should create avoirremb" do
    visit avoirrembs_url
    click_on "New avoirremb"

    fill_in "Commande", with: @avoirremb.commande_id
    fill_in "Montant", with: @avoirremb.montant
    fill_in "Natureavoirremb", with: @avoirremb.natureavoirremb
    fill_in "Typeavoirremb", with: @avoirremb.typeavoirremb
    click_on "Create Avoirremb"

    assert_text "Avoirremb was successfully created"
    click_on "Back"
  end

  test "should update Avoirremb" do
    visit avoirremb_url(@avoirremb)
    click_on "Edit this avoirremb", match: :first

    fill_in "Commande", with: @avoirremb.commande_id
    fill_in "Montant", with: @avoirremb.montant
    fill_in "Natureavoirremb", with: @avoirremb.natureavoirremb
    fill_in "Typeavoirremb", with: @avoirremb.typeavoirremb
    click_on "Update Avoirremb"

    assert_text "Avoirremb was successfully updated"
    click_on "Back"
  end

  test "should destroy Avoirremb" do
    visit avoirremb_url(@avoirremb)
    click_on "Destroy this avoirremb", match: :first

    assert_text "Avoirremb was successfully destroyed"
  end
end
