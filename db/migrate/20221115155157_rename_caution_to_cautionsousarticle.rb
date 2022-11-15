class RenameCautionToCautionsousarticle < ActiveRecord::Migration[7.0]
  def change
    rename_column :sousarticles, :caution, :caution_sousarticle
  end
end
