class CreateUserRewards < ActiveRecord::Migration
  def change
    create_table :user_rewards do |t|
      t.references :hcf_reward, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.boolean :redeemed

      t.timestamps null: false
    end
  end
end
