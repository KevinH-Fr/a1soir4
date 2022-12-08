class Post < ApplicationRecord

    validates :name, presence: true
    validates :content, presence: false

    enum title: {
        draf: 'draft',
        published: 'published',
        passcode_protected: 'passcode_protected'
    }

end
