class Client < ApplicationRecord
    has_many :commandes

    validates :nom, presence: true

  #  after_create_commit { broadcast_append_to('clients') }

    def full_name
        "#{nom} #{mail} "
    end
end
