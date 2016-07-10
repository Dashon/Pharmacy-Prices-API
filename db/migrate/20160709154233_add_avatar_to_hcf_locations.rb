class AddAvatarToHcfLocations < ActiveRecord::Migration
  def self.up
    add_attachment :hcf_locations, :image_url
  end

  def self.down
    remove_attachment :hcf_locations, :image_url
  end
end
