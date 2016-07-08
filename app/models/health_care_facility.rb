class HealthCareFacility < ActiveRecord::Base
  has_many :users , dependent: :destroy
  has_many :hcf_locations

  def active_model_serializer
    ShortHealthCareFacilitySerializer
  end

end
