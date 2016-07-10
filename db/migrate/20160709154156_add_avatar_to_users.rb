class AddAvatarToUsers < ActiveRecord::Migration
   def self.up
    add_attachment :users, :image_url
  end

  def self.down
    remove_attachment :users, :image_url
  end
end
