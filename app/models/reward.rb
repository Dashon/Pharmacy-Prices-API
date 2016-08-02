class Reward < ActiveRecord::Base
  belongs_to :user
  enum reward_type_list: {trophy: 1, avatar: 2, badge: 3}


  validates :image_url,
    attachment_content_type: { content_type: /\Aimage\/.*\Z/ },
    attachment_size: { less_than: 2.megabytes }

  has_attached_file :image_url, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  },  default_url:'/assets/images/missing/default_:style.png'

end
