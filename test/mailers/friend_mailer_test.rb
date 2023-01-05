require "test_helper"

class FriendMailerTest < ActionMailer::TestCase
  test "new_friend" do
    mail = FriendMailer.new_friend
    assert_equal "New friend", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
