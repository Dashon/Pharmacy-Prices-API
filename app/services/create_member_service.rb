class CreateMemberService
  def call
  user = User.find_or_create_by!(email: "member@asianh.com") do |user|
      user.name = Rails.application.secrets.admin_name
      user.password = Rails.application.secrets.admin_password
      user.password_confirmation = Rails.application.secrets.admin_password
      user.confirmed_at = DateTime.now
      user.team_member!
    end
  end
end
