class CommandeMailer < ApplicationMailer

  def commande_created
    @user = params[:user]

    @commande = params[:commande]

    @greeting = "Hi"

    attachments['logo1.png'] = File.read('app/assets/images/logo1.png')


    mail(

      to: User.first.email,
      subject: "bonCommande"
      #, cc: User.all.pluck(:email)
      #, bcc
    )

  end
end
