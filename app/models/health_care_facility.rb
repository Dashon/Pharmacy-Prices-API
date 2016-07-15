class HealthCareFacility < ActiveRecord::Base
  has_many :users , dependent: :destroy
  has_many :hcf_locations

  has_many :contracted_pharmacies 
  has_many :hcf_pharmacies 
 has_many :pharmacies, :through => :hcf_pharmacies , source: "dni_pharmacy"
 has_many :contracted, :through => :contracted_pharmacies , source: "dni_pharmacy"

  validates :image_url,
    attachment_content_type: { content_type: /\Aimage\/.*\Z/ },
    attachment_size: { less_than: 2.megabytes }

  has_attached_file :image_url, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  },  default_url:'/assets/images/missing/default_:style.png'

  def active_model_serializer
    ShortHealthCareFacilitySerializer
  end

end
