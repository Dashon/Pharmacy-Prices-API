class CreateDrugPrices < ActiveRecord::Migration
  def change
    create_table :drug_prices do |t|
      t.float :days_supply
      t.float :quantity
      t.string :generic_id
      t.string :ndc11

      t.timestamps
    end
  end
end
