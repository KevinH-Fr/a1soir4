class CommandeMailer < ApplicationMailer

 # default from: "from@example.com"
 # layout "mailer"

  def commande_created(commande)

   # @commande = Commande.find(params[:id])
   # @user = params[:user]

    @commande = commande

    @client = @commande.client_id
    @clientMail = Client.find(@client).mail

    @greeting = "Hi"

    @intituleClient = Client.find(@client).intitule_nom

    @nomDocument = @commande
    @evenement = @commande.typeevenement
    @dateEvent = @commande.dateevenement
    @texteBase = "Merci de trouver ci-attaché le document cité en objet pour votre #{@evenement} du #{@dateEvent}."

    attachments['logo1.png'] = File.read('app/assets/images/logo1.png')


    mail(

      to:  @clientMail,
      subject: "Commande " ##{@commande.full_name}
      #, cc: User.all.pluck(:email)
      #, bcc
    )

  end

end
