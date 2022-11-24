# Preview all emails at http://localhost:3000/rails/mailers/post_mailer
class CommandeMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/post_mailer/post_created
  def commande_created
    CommandeMailer.with(user: User.first, commande: Commande.first).commande_created
  end


end
