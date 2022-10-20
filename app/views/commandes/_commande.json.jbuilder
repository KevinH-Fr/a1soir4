json.extract! commande, :id, :nom, :montant, :created_at, :updated_at
json.url commande_url(commande, format: :json)
