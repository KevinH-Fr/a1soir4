class Profile < ApplicationRecord

    def full_name
        "#{prenom} #{nom} "
    end
end
