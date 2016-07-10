class CreateContractedPharmacies < ActiveRecord::Migration
  def change
    create_table :contracted_pharmacies do |t|
      t.references :hcf_pharmacy, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.references :health_care_facility, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :contracted_pharmacies, [:health_care_facility_id, :hcf_pharmacy_id], unique: true, :name => 'unique_contracted_pharmacies'
  end
end
