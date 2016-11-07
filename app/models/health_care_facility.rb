class HealthCareFacility < ActiveRecord::Base
  has_many :users , dependent: :destroy
  has_many :hcf_locations

  has_many :contracted_pharmacies
  has_many :hcf_pharmacies
  has_many :hcf_rewards
  has_many :pharmacies, :through => :hcf_pharmacies , source: "dni_pharmacy"
  has_many :contracted, :through => :contracted_pharmacies , source: "dni_pharmacy"
  has_many :rewards, :through => :hcf_rewards

  # validates :image_url,
  #   attachment_content_type: { content_type: /\Aimage\/.*\Z/ },
  #   attachment_size: { less_than: 2.megabytes }

  # has_attached_file :image_url, styles: {
  #   thumb: '100x100>',
  #   square: '200x200#',
  #   medium: '300x300>'
  # },  default_url:'/assets/images/missing/default_:style.png'

  def active_model_serializer
    ShortHealthCareFacilitySerializer
  end

  def top_users
    users = []
    self.users.each do |user|
      points = 0
      user.answers.where(created_at: 1.month.ago..Time.now).each do |answer|
        points = points + answer.question.value
      end
      # user.points = points
      users.push({:name => user.name, :avatar => user.image_url, :points => points})
    end

    users.sort_by { |hsh| hsh[:points] }.reverse.take(3)
  end


  def month_trophy
    Reward.where(reward_type: Date.today.strftime("%B")).first
  end

  def next_reward
    Reward.where(reward_type: 'next').first
  end


  def team_month_points
    points = 0
      self.users.each do |user|
        user.answers.where(created_at: Time.zone.now.beginning_of_month..Time.now).each do |answer|
          points = points + answer.question.value
        end
    end
    points
  end

  def team_total_points
    points = 0
      self.users.each do |user|
        user.answers.each do |answer|
          points = points + answer.question.value
        end
    end
    points
  end

end
