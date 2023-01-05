class FriendMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.friend_mailer.new_friend.subject
  #
  def new_friend()
    
    @pdf = params[:pdf]

    @friend = Friend.first
    friend = Friend.first

  #  pdf = WickedPdf.new.pdf_from_string(
  #    render_to_string(template: "friends/documentEdit", 
  #                     formats: [:html],
  #                     disposition: :inline,              
  #                     layout: 'pdf')
  #  )
    attachments["friend_#{friend.id}.pdf"] = @pdf 

    mail to: "kevin.hoffman.france@gmail.com"
  end
end
