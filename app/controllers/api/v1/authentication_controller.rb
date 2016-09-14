class Api::V1::AuthenticationController < Api::ApiController

  def authenticate_user
    user = User.find_for_database_authentication(email: params[:email])
    if user.valid_password?(params[:password])
      render json: payload(user)
    else
      render json: {errors: ['Invalid Username/Password']}, :status=>422
    end
  end

  def update_password
    @user = User.find(current_user.id)
    if @user.update(user_params)
      sign_in @user, :bypass => true
      render json: payload(@user)
    else
      render json: {errors: ['Failed to update Password']}, :status=>422
    end
  end


  def reset_password
    @user = User.find_by_reset_password_token!(Devise.token_generator.digest(User.class, :reset_password_token, params[:reset_password_token]))

    if @user.reset_password_sent_at < 2.hours.ago
      render json: {errors: ['Password reset has expired.']}, :status=>422
    elsif @user.update_attributes(reset_params)
      render :text => {response: ['Password has been reset!']}
    else
      render :edit
    end
  end

  def forgot_password
    @user = User.find_by_email(params[:email])
    if @user.present?
      @user.send_reset_password_instructions
      render :text => {response: ['Reset Password Instructions Sent']}
    else
      render json: {errors: ['No such email']}, status: :not_found
    end
  end

  def invite_user
    params[:password] = "Docandi2016"
    existing = true
    if !params[:role]
      params[:role] = 2
    end

    if !params[:health_care_facility_id]
      params[:health_care_facility_id] = current_user.health_care_facility_id
    end
    user = User.first(user_id: 'email')

    if user == nil
      existing = false
      user = User.new(invite_params)
      user.image_url ="http://doc-and-i-bucket.s3.amazonaws.com/rewards/image_urls/000/000/005/original/data?1470228088"
      user.skip_confirmation!
    end

    if current_user.doc_and_i_admin?
      user.health_care_facility_id = params[:health_care_facility_id]
    elsif (current_user.team_admin? && current_user.health_care_facility_id == params[:health_care_facility_id])
      unless params[:role] == 18650
        user.health_care_facility_id = current_user.health_care_facility_id
      end
    end

    if user.save
      if !existing
        user.send_reset_password_instructions
      end
      render json: payload(user)
      return
    else
      render :json=> user.errors, :status=>422
    end
      render :json=> "Internal", :status=>500

  end

  def log_out
    @user = User.find(current_user.id)
    if @user != nil
      sign_out @user
      render json: payload(@user)
    else
      render json: {errors: ['Failed to logout']}, :status=>422
    end
  end
  private

  def payload(user)
    return nil unless user and user.id
    {
      auth_token: JsonWebToken.encode({user_id: user.id}),
      user: {id: user.id, name: user.name, hcf_id: user.health_care_facility_id, role: user.role}
    }
  end

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end

  def reset_params
    params.permit(:password, :password_confirmation)
  end


  def invite_params
    params.permit(:email, :role, :health_care_facility_id, :password, :name)
  end

end
