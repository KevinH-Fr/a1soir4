class ClientMailer < ApplicationMailer

  #helper CommandeHelper #rendre disponible l'helper commande pour calculs synthese

  def client_created(client)

   

    mail(
      to:  "test",
      subject: "test", 
      cc: "kevin.hoffman.france@gmail.com"
      
    )

  end

end
