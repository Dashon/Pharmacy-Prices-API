class User < ActiveRecord::Base
  enum role: [:api_user, :admin]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :api_user
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

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
