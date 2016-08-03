class User < ActiveRecord::Base

  # Include default devise modules.
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable,
    :confirmable
  belongs_to :health_care_facility
  has_many :user_rewards
  has_many :hcf_rewards, :through => :user_rewards
  has_many :rewards, :through => :hcf_rewards
  has_many :surveys
  has_many :answers, :through => :surveys

  # validates :image_url,
  #   attachment_content_type: { content_type: /\Aimage\/.*\Z/ },
  #   attachment_size: { less_than: 2.megabytes }

  # has_attached_file :image_url, styles: {
  #   thumb: '100x100>',
  #   square: '200x200#',
  #   medium: '300x300>'
  # },  default_url:'/assets/images/missing/default_:style.png'

  enum role: {doc_and_i_admin: 18650, api_user: 1, team_member: 2, team_admin: 3}

  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :team_member
  end

  def month_points
    points = 0
    self.answers.each do |answer|
      points = points + answer.question.value
    end
    points
  end

  def total_points
    points = 0
    self.answers.where(created_at: 1.month.ago..Time.now).each do |answer|
      points = points + answer.question.value
    end
    points
  end

  def team_month_points
    points = 0
    if (self.health_care_facility)
      self.health_care_facility.users.each do |user|
        self.answers.where(created_at: 1.month.ago..Time.now).each do |answer|
          points = points + answer.question.value
        end
      end
    end
    points
  end

  def team_total_points
    points = 0
    if (self.health_care_facility)
      self.health_care_facility.users.each do |user|
        self.answers.each do |answer|
          points = points + answer.question.value
        end
      end
    end
    points
  end

  def trophies
    self.rewards.where(reward_type: 'trophy') +  Reward.where(reward_type: 'starter_trophy') 
  end

  def avatars
    self.rewards.where(reward_type: 'avatar') +  Reward.where(reward_type: 'starter_avatar') 
  end

  def badges
    self.rewards.where(reward_type: 'badge') +  Reward.where(reward_type: 'starter_badge') 

  end
  DEFAULT_API_RPM =  1000

  before_create do |doc|
    doc.api_token = User.generate_api_key
    doc.api_rpm = DEFAULT_API_RPM if doc.api_rpm == 0
    doc.uid = doc.email
  end

  def self.generate_api_key
    loop do
      token = SecureRandom.uuid
      break token unless User.exists?(api_token: token)
    end
  end
end
