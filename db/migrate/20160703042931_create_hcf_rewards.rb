class CreateHcfRewards < ActiveRecord::Migration
  def change
    create_table :hcf_rewards do |t|
      t.references :reward, index: true, foreign_key: true
      t.references :health_care_facility, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
