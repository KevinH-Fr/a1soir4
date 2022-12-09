json.extract! profile, :id, :prenom, :nom, :created_at, :updated_at
json.url profile_url(profile, format: :json)
