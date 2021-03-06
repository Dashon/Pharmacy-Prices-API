class CreateDniPharmacies < ActiveRecord::Migration
  def change
    create_table :dni_pharmacies do |t|
      t.string :name
      t.string :address
      t.string :phone
      t.string :email
      t.string :city
      t.string :state
      t.string :zip
      t.float :latitude
      t.float :longitude
      t.integer :match_score
      t.references :user, index: true, foreign_key: true
      t.string :surescripts_id
      t.string :stateList_id
      t.string :npi
      t.string :short_code, index:true
      t.string :image_url
      t.boolean :active, null: false, default: false
      t.boolean :overide_geocoder, null: false, default: false
      t.timestamps null: false
    end
  end
end
