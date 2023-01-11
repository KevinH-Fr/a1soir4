class ClientMailer < ApplicationMailer

  #helper CommandeHelper #rendre disponible l'helper commande pour calculs synthese

  def client_created(client, messagemail)

   @client = client
   @messagemail = messagemail

    mail(
      to:  @messagemail.mail,
      subject: "test", 
      cc: "kevin.hoffman.france@gmail.com"
      
    )

  end

end
