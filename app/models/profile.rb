class Profile < ApplicationRecord

    has_many :commandes
    has_one_attached :image1

    def full_name
        "#{prenom} #{nom} "
    end

    def default_image
        if self.image1.filename.to_s.length > 0 
            image1
        else
            "no_photo.png"
        end
    end
    
end
