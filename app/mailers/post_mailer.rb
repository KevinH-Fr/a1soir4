class PostMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.post_mailer.post_created.subject
  #
  def post_created
    @user = params[:user]
    @post = params[:post]
    @greeting = "Hi"

    attachments['logo1.png'] = File.read('app/assets/images/logo1.png')


    mail(

      to: User.first.email,
      subject: "new post created"
      #, cc: User.all.pluck(:email)
      #, bcc
    )

  end
end
