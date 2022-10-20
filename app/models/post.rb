class Post < ApplicationRecord

    validates :title, presence: true
    validates :content, presence: true

    enum title: {
        draf: 'draft',
        published: 'published',
        passcode_protected: 'passcode_protected'
    }




end
