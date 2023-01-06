class CommandeMailer < ApplicationMailer

  # default from: "from@example.com"


  helper CommandeHelper #rendre disponible l'helper commande pour calculs synthese

  def commande_created(commande, typedoc)

    @typedoc = typedoc
    @commande = commande
  

    @pdf = params[:pdf]

    @client = @commande.client_id
    @clientMail = Client.find(@client).mail
    @intituleClient = Client.find(@client).intitule_nom
    @mailobject = "#{typedoc}_" "#{@commande.nom}"
    @nomDocument = "#{typedoc}_" "#{@commande.id}"
    @evenement = @commande.typeevenement ? @commande.typeevenement : "événement"
    @dateEvent = @commande.dateevenement ? " du #{@commande.dateevenement.strftime("%d/%m/%y")}" : ""
    @texteBase = "Merci de trouver ci-attaché votre 
                  #{@typedoc} pour votre #{@evenement} 
                  #{@dateEvent}."

    attachments['logo1.png'] = File.read('app/assets/images/logo1.png')
    
    attachments["commande_#{commande.id}.pdf"] = @pdf 
    
    #attachments.inline["logo1.png"] = File.read('app/assets/images/logo1.png')
    #attachments.inline['logo_courant.png'] = File.read('public/logo_courant.png')

    #pdf = WickedPdf.new.pdf_from_html_file(
    #  render_to_string('commandes/bonCommande', layout: 'pdf')
       
    #)
    #attachments["#{@nomDocument}.pdf"] = pdf


   # attachments["commande.pdf"] = WickedPdf.new.pdf_from_string(
   #   render_to_string(template: 'commandes/bonCommande', locals: {commande: @commande}, layout: 'pdf', formats: [:html])
   # )

   # attachments["#{@nomDocument}.pdf"] = 

   # WickedPdf.new.pdf_from_html_file(
   # render_to_string('commandes/bonCommande', layout: 'pdf'),
   #   header: {
   #     content: render_to_string(
   #       'shared/doc_entete',
   #       layout: 'pdf'
   #     )
   #   },
   #   footer: {
   #     content: render_to_string(
   #       'shared/doc_footer',
   #       layout: 'pdf'
   #     )
   #   }
   # )

    mail(
      to:  @clientMail,
      subject: @mailobject, 
      cc: "kevin.hoffman.france@gmail.com"
      #, bcc
    )

  end

end
