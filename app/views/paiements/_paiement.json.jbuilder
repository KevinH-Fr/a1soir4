json.extract! paiement, :id, :type, :montant, :commande_id, :created_at, :updated_at
json.url paiement_url(paiement, format: :json)
