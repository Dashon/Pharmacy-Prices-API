class CreateDrugs < ActiveRecord::Migration
  def change
    create_table :drugs do |t|
      t.string :ndc11
      t.string :name
      t.string :name_prefix
      t.string :generic_id
      t.string :therapy_class_id

      t.timestamps
    end
  end
end
