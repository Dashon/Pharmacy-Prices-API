class HcfReward < ActiveRecord::Base
  belongs_to :reward
  belongs_to :health_care_facility
  belongs_to :user

  validates :image_url,
    attachment_content_type: { content_type: /\Aimage\/.*\Z/ },
    attachment_size: { less_than: 2.megabytes }

  has_attached_file :image_url, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  },  default_url:'/assets/images/missing/default_:style.png'

end
