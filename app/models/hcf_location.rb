class HcfLocation < ActiveRecord::Base
  belongs_to :user
  belongs_to :health_care_facility

  geocoded_by :full_street_address   # can also be an IP address
  after_validation :geocode ,if: ->(obj){ obj.address.present? and obj.address_changed? }

  validates :image_url,
    attachment_content_type: { content_type: /\Aimage\/.*\Z/ },
    attachment_size: { less_than: 2.megabytes }

  has_attached_file :image_url, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  },  default_url:'/assets/images/missing/default_:style.png'

def full_street_address
[address, city, state].compact.join(', ')
end

end
