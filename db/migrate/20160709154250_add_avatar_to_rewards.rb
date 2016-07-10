class AddAvatarToRewards < ActiveRecord::Migration

  def self.up
    add_attachment :rewards, :image_url
  end

  def self.down
    remove_attachment :rewards, :image_url
  end

end
