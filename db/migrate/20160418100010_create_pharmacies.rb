class CreatePharmacies < ActiveRecord::Migration
  def change
    create_table :pharmacies do |t|
      t.float :distance_miles_max
      t.string :distance_from_zip

      t.timestamps
    end
  end
end
