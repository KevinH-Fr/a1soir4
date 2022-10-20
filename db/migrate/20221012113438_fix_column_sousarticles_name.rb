class FixColumnSousarticlesName < ActiveRecord::Migration[7.0]
  def change
    rename_column :sousarticles, :prix, :prix_sousarticle
  end
end
