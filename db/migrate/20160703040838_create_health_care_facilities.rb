class CreateHealthCareFacilities < ActiveRecord::Migration
  def change
    create_table :health_care_facilities do |t|
      t.string :name
      t.references :user, index: true, foreign_key: true
      t.string :image_url

      t.timestamps null: false
    end
  end
end
