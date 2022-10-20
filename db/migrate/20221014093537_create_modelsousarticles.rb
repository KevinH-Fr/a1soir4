class CreateModelsousarticles < ActiveRecord::Migration[7.0]
  def change
    create_table :modelsousarticles do |t|
      t.string :nature
      t.text :description
      t.decimal :prix
      t.decimal :caution

      t.timestamps
    end
  end
end
