class MessagemailMailer < ApplicationMailer

    def messagemail_created(messagemail)

       # @client = client
        @messagemail = messagemail
     
         mail(
           to: @messagemail.mail,
           subject: "test", 
           cc: "kevin.hoffman.france@gmail.com"
           
         )
     
       end
end
