require "test_helper"

class MessagemailsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @messagemail = messagemails(:one)
  end

  test "should get index" do
    get messagemails_url
    assert_response :success
  end

  test "should get new" do
    get new_messagemail_url
    assert_response :success
  end

  test "should create messagemail" do
    assert_difference("Messagemail.count") do
      post messagemails_url, params: { messagemail: { body: @messagemail.body, client_id: @messagemail.client_id, commande_id: @messagemail.commande_id, titre: @messagemail.titre } }
    end

    assert_redirected_to messagemail_url(Messagemail.last)
  end

  test "should show messagemail" do
    get messagemail_url(@messagemail)
    assert_response :success
  end

  test "should get edit" do
    get edit_messagemail_url(@messagemail)
    assert_response :success
  end

  test "should update messagemail" do
    patch messagemail_url(@messagemail), params: { messagemail: { body: @messagemail.body, client_id: @messagemail.client_id, commande_id: @messagemail.commande_id, titre: @messagemail.titre } }
    assert_redirected_to messagemail_url(@messagemail)
  end

  test "should destroy messagemail" do
    assert_difference("Messagemail.count", -1) do
      delete messagemail_url(@messagemail)
    end

    assert_redirected_to messagemails_url
  end
end
