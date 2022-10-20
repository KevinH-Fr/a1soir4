class Modelsousarticle < ApplicationRecord

    scope :sous_article_courant, ->  (sous_article_courant) { where("nature = ?", sous_article_courant)}

end
