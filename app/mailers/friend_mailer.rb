class FriendMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.friend_mailer.new_friend.subject
  #
  def new_friend(friend)

    @friend = Friend.first
    friend = Friend.first

    pdf = WickedPdf.new.pdf_from_string(
      render_to_string(template: "friends/show", 
                       formats: [:html],
                       disposition: :inline,              
                       layout: 'pdf')
    )
    attachments["friend_#{friend.id}.pdf"] = pdf 

    mail to: "kevin.hoffman.france@gmail.com"
  end
end