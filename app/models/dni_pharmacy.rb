class DniPharmacy < ActiveRecord::Base
  belongs_to :user
  after_create :set_short_code
  has_many :pharmacy_benefits
  has_many :benefits, :through => :pharmacy_benefits

  geocoded_by :full_street_address   # can also be an IP address
  after_validation :geocode ,if: ->(obj){ (obj.address.present? and obj.address_changed? and !obj.overide_geocoder?) or (obj.latitude.nil? or obj.longitude.nil?) }

  def set_short_code
    hashids = Hashids.new 'DocAndI5', 5 ,'ABCDEFGHIJKLMNPQRSTUVWXYZ1234567890'
    self.short_code = hashids.encode(self.id)
    self.save
  end

  def full_street_address
    [address, city, state].compact.join(', ')
  end

  def display_name
    name+" - "+address+" "+[city, state].compact.join(', ')
  end

  attr_writer :contracted

  def contracted
    @contracted || false
  end
end
