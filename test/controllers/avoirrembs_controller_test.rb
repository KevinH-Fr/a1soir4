require "test_helper"

class AvoirrembsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @avoirremb = avoirrembs(:one)
  end

  test "should get index" do
    get avoirrembs_url
    assert_response :success
  end

  test "should get new" do
    get new_avoirremb_url
    assert_response :success
  end

  test "should create avoirremb" do
    assert_difference("Avoirremb.count") do
      post avoirrembs_url, params: { avoirremb: { commande_id: @avoirremb.commande_id, montant: @avoirremb.montant, natureavoirremb: @avoirremb.natureavoirremb, typeavoirremb: @avoirremb.typeavoirremb } }
    end

    assert_redirected_to avoirremb_url(Avoirremb.last)
  end

  test "should show avoirremb" do
    get avoirremb_url(@avoirremb)
    assert_response :success
  end

  test "should get edit" do
    get edit_avoirremb_url(@avoirremb)
    assert_response :success
  end

  test "should update avoirremb" do
    patch avoirremb_url(@avoirremb), params: { avoirremb: { commande_id: @avoirremb.commande_id, montant: @avoirremb.montant, natureavoirremb: @avoirremb.natureavoirremb, typeavoirremb: @avoirremb.typeavoirremb } }
    assert_redirected_to avoirremb_url(@avoirremb)
  end

  test "should destroy avoirremb" do
    assert_difference("Avoirremb.count", -1) do
      delete avoirremb_url(@avoirremb)
    end

    assert_redirected_to avoirrembs_url
  end
end
