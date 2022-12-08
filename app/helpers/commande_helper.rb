module CommandeHelper
    def du_prix(commande)
        duPrix = Article.commande_courante(@commande).sum_articles + 
        Article.joins(:sousarticles).commande_courante(@commande).sum_sousarticles
    end
    def du_caution(commande)
        duCaution = Article.commande_courante(@commande).sum_caution
    end 
    def recu_prix(commande)
        recuPrix = Paiement.commande_courante(@commande).prix_only.sum_paiements
    end 
    def recu_caution(commande)
        recuCaution = Paiement.commande_courante(@commande).caution_only.sum_paiements
    end 

    def avoirremb_deduit(commande)
        avoirrembDeduit = Avoirremb.commande_courante(@commande).sum_avoirrembs
    end 

    def solde_prix(commande)
        soldePrix = du_prix(commande) - recu_prix(commande) - avoirremb_deduit(commande)
    end
    def solde_caution(commande)
        soldeCaution = du_caution(commande) - recu_caution(commande)
    end


    # test helper pour editer pdf
    def edition_pdf(commande)

    end 

end 