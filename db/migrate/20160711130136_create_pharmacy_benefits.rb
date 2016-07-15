class CreatePharmacyBenefits < ActiveRecord::Migration
  def change
    create_table :pharmacy_benefits do |t|
      t.references :benefit, index: true, foreign_key: true
      t.references :dni_pharmacy, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
