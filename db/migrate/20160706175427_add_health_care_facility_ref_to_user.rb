class AddHealthCareFacilityRefToUser < ActiveRecord::Migration
  def change
    add_reference :users, :health_care_facility, index: true, foreign_key: true
  end
end
