require "test_helper"

class CommandeMailerTest < ActionMailer::TestCase
  test "commande_created" do
    mail = CommandeMailer.commande_created
    assert_equal "Commande created", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
