class CreateHcfLocations < ActiveRecord::Migration
  def change
    create_table :hcf_locations do |t|
      t.string :address
      t.string :phone
      t.string :name
      t.string :email
      t.string :city
      t.string :state
      t.string :zip
      t.string :image_url
      t.references :user, index: true, foreign_key: true
      t.references :health_care_facility, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
