class CreateBenefits < ActiveRecord::Migration
  def change
    create_table :benefits do |t|
      t.string :name
      t.string :description
      t.string :image_url

      t.timestamps null: false
    end
  end
end
