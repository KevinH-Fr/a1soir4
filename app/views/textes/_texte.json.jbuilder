json.extract! texte, :id, :titre, :created_at, :updated_at
json.url texte_url(texte, format: :json)
