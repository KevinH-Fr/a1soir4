module ArticleHelper

  def calcul_dispo(article)
    initial = Produit.find(article).quantite
    ventes = Article.produit_courant(article).articlesVendus.compte_articles

    commandeId = params[:commandeId]
    
    if commandeId.present?
     # nb loc du produit courant dont les dates de locs se superposent avec la commande courante
      dateDebut = Commande.find(commandeId).debutloc
      valDate = dateDebut.to_date if dateDebut.present?
      louesPeriode = Commande.a_date(valDate).joins(:articles)
        .merge(Article.produit_courant(article)).sum(:quantite) 
    end 
     
    dispo = initial.to_i - ventes.to_i - louesPeriode.to_i

  end 
end