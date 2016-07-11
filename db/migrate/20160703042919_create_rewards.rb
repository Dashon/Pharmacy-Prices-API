class CreateRewards < ActiveRecord::Migration
  def change
    create_table :rewards do |t|
      t.string :name
      t.string :reward_type
      t.integer :cost
      t.string :description
      t.binary :image_url
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
