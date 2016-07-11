class CreatePharmacyEditRequests < ActiveRecord::Migration
  def change
    create_table :pharmacy_edit_requests do |t|
      t.string :name
      t.string :address
      t.string :phone
      t.string :email
      t.string :city
      t.string :state
      t.string :zip
      t.string :latitude
      t.string :longitude
      t.string :surescripts_id
      t.string :stateList_id
      t.references :dni_pharmacy, index: true, foreign_key: true
      t.boolean :approved, null: false, default: false
      t.boolean :denied, null: false, default: false
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
