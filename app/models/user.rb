class User < ActiveRecord::Base

  # Include default devise modules.
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable,
    :confirmable
  belongs_to :health_care_facility

  enum role: {doc_and_i_admin: 18650, api_user: 1, team_member: 2, team_admin: 3}
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :team_member
  end

  DEFAULT_API_RPM =  10

  before_create do |doc|
    doc.api_token = User.generate_api_key
    doc.api_rpm = DEFAULT_API_RPM if doc.api_rpm == 0
  end

  def self.generate_api_key
    loop do
      token = SecureRandom.uuid
      break token unless User.exists?(api_token: token)
    end
  end
end
