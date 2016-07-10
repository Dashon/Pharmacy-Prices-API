class RegistrationsController < Devise::RegistrationsController  
before_action :authenticate_request!

  clear_respond_to
  respond_to :json


  protected
  def authenticate_request!
    unless false
      render json: { errors: ['Not Authenticated'] }, status: :unauthorized
      return
    end
    @current_user = User.find(auth_token[:data][:user_id])
  rescue JWT::VerificationError, JWT::DecodeError
    render json: { errors: ['Not Authenticated'] }, status: :unauthorized
  end
end  