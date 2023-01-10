require "application_system_test_case"

class MessagemailsTest < ApplicationSystemTestCase
  setup do
    @messagemail = messagemails(:one)
  end

  test "visiting the index" do
    visit messagemails_url
    assert_selector "h1", text: "Messagemails"
  end

  test "should create messagemail" do
    visit messagemails_url
    click_on "New messagemail"

    fill_in "Body", with: @messagemail.body
    fill_in "Client", with: @messagemail.client_id
    fill_in "Commande", with: @messagemail.commande_id
    fill_in "Titre", with: @messagemail.titre
    click_on "Create Messagemail"

    assert_text "Messagemail was successfully created"
    click_on "Back"
  end

  test "should update Messagemail" do
    visit messagemail_url(@messagemail)
    click_on "Edit this messagemail", match: :first

    fill_in "Body", with: @messagemail.body
    fill_in "Client", with: @messagemail.client_id
    fill_in "Commande", with: @messagemail.commande_id
    fill_in "Titre", with: @messagemail.titre
    click_on "Update Messagemail"

    assert_text "Messagemail was successfully updated"
    click_on "Back"
  end

  test "should destroy Messagemail" do
    visit messagemail_url(@messagemail)
    click_on "Destroy this messagemail", match: :first

    assert_text "Messagemail was successfully destroyed"
  end
end
