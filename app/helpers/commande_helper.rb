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

    def avoir_deduit(commande)
        avoirDeduit = Avoirremb.commande_courante(@commande).avoir_only.sum_avoirrembs
    end 

    def remb_deduit(commande)
        remb_Deduit = Avoirremb.commande_courante(@commande).remboursement_only.sum_avoirrembs
    end 

    def avoirremb_deduit(commande)
        avoirrembDeduit = Avoirremb.commande_courante(@commande).sum_avoirrembs
    end 

    def solde_prix(commande)
        soldePrix = du_prix(commande) - recu_prix(commande) - avoir_deduit(commande) + remb_deduit(commande)
    end
    
    def solde_caution(commande)
        soldeCaution = du_caution(commande) - recu_caution(commande)
    end


    # ?? utlisé ? test helper pour editer pdf
    def edition_pdf(commande)

        typedoc = params[:typedoc]
        typeedition = params[:typeedition]
    
        commande = Commande.find(params[:id])

        CommandeMailer.commande_created(commande).deliver_now
          flash[:notice] = "le mail a bien été envoyé"
        #  redirect_to commande_path(commande)
    
        #end 

    end 

end 