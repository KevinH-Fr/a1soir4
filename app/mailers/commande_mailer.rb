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

    if @commande.typeevenement.present?
      @evenement = @commande.typeevenement
    else
      @evenement = "événement"
    end 

    if @commande.dateevenement.present?
      @dateEvent = " du #{@commande.dateevenement.strftime("%d/%m/%y")}"
    else
      @dateEvent = ""
    end 
   
    @dateEvent = @commande.dateevenement ? " du #{@commande.dateevenement.strftime("%d/%m/%y")}" : ""
    
    @texteBase = "Merci de trouver ci-attaché votre 
                  #{@typedoc} pour votre #{@evenement}#{@dateEvent}""."

    attachments['logo1.png'] = File.read('app/assets/images/logo1.png')
    
    attachments["#{typedoc}_#{commande.id}.pdf"] = @pdf 

    mail(
      to:  @clientMail,
      subject: @mailobject, 
      cc: "kevin.hoffman.france@gmail.com"
      #, bcc
    )

  end

end
