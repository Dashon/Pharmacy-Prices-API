class AddAvatarToHealthCareFacilities < ActiveRecord::Migration
   def self.up
    add_attachment :health_care_facilities, :image_url
  end

  def self.down
    remove_attachment :health_care_facilities, :image_url
  end
end
