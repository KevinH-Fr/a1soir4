class CommandeMailer < ApplicationMailer

  # default from: "from@example.com"
  # layout "mailer"

  helper CommandeHelper #rendre disponible l'helper commande pour calculs synthese

  def commande_created(commande, typedoc)

    @typedoc = typedoc

    @commande = commande

    @client = @commande.client_id
    @clientMail = Client.find(@client).mail
    @intituleClient = Client.find(@client).intitule_nom
    @mailobject = "#{typedoc}_" "#{@commande.full_name}"
    @nomDocument = "#{typedoc}_" "#{@commande.id}"
    @evenement = @commande.typeevenement
    @dateEvent = @commande.dateevenement
    @texteBase = "Merci de trouver ci-attaché le document cité en objet pour votre #{@evenement} du #{@dateEvent}."

    attachments['logo1.png'] = File.read('app/assets/images/logo1.png')
    attachments["#{@nomDocument}.pdf"] = WickedPdf.new.pdf_from_string(
      render_to_string(template: 'commandes/bonCommande', locals: {commande: @commande, typedoc: typedoc}, layout: 'pdf', formats: [:html])
    )


    mail(
      to:  @clientMail,
      subject: @mailobject, 
      cc: "kevin.hoffman.france@gmail.com"
      #, bcc
    )

  end

end
