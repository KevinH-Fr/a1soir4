class CommandeMailer < ApplicationMailer

  # default from: "from@example.com"
  # layout "mailer"

  helper CommandeHelper #rendre disponible l'helper commande pour calculs synthese

  def commande_created(commande)

    @commande = commande

    @client = @commande.client_id
    @clientMail = Client.find(@client).mail
    @intituleClient = Client.find(@client).intitule_nom
    @mailobject = "Commande #{@commande.full_name}"
    @nomDocument = @commande
    @evenement = @commande.typeevenement
    @dateEvent = @commande.dateevenement
    @texteBase = "Merci de trouver ci-attaché le document cité en objet pour votre #{@evenement} du #{@dateEvent}."

    attachments['logo1.png'] = File.read('app/assets/images/logo1.png')
    attachments["commande.pdf"] = WickedPdf.new.pdf_from_string(
      render_to_string(template: 'commandes/bonCommande', locals: {commande: @commande}, layout: 'pdf', formats: [:html])
    )


    mail(
      to:  @clientMail,
      subject: @mailobject, 
      cc: "kevin.hoffman.france@gmail.com"
      #, bcc
    )

  end

end
