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
      user: {id: user.id, email: user.email}
    }
  end


  def user_params
    params.permit(:password, :password_confirmation)
  end

end
