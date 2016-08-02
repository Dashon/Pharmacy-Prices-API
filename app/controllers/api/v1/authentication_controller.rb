class Api::V1::AuthenticationController < Api::ApiController

  def authenticate_user
    user = User.find_for_database_authentication(email: params[:email])
    if user.valid_password?(params[:password])
      render json: payload(user)
    else
      render json: {errors: ['Invalid Username/Password']}, status: :unauthorized
    end
  end

  def update_password
    @user = User.find(current_user.id)
    if @user.update(user_params)
      sign_in @user, :bypass => true
      render json: payload(@user)
    else
      render json: {errors: ['Failed to update Password']}, status: :unauthorized
    end
  end

  def forgot_password
    @user = User.find_by_email(params[:email])
    if @user.present?
      @user.send_reset_password_instructions
      render :text => {response: ['Reset Password Instructions Sent']}
    else
      render json: {errors: ['No such email']}, status: :unauthorized
    end
  end

  def sign_out
    @user = User.find(current_user.id)
    if @user.update(user_params)
      sign_out @user
      # render json: payload(@user)
    else
      render json: {errors: ['Failed to update Password']}, status: :unauthorized
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
    params.permit(:password, :password_confirmation)
  end

end
