class CreateLabels < ActiveRecord::Migration[7.0]
  def change
    create_table :labels do |t|
      t.text :principale
      t.text :soiree
      t.text :mariee
      t.text :homme
      t.text :accessoire
      t.text :deguisement

      t.timestamps
    end
  end
end
