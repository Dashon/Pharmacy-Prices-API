class CreateHcfPharmacies < ActiveRecord::Migration
  def change
    create_table :hcf_pharmacies do |t|
      t.string :external_id
      t.references :health_care_facility, index: true, foreign_key: true
      t.references :dni_pharmacy, index: true, foreign_key: true

      t.timestamps null: false
  end
      add_index :hcf_pharmacies, [:health_care_facility_id, :dni_pharmacy_id], unique: true, :name => 'unique_dni_pharmacies'
  end
end




