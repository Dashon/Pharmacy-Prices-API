class Api::ApiController < ActionController::Base
  #before_action :authenticate
  before_action :authenticate_manual
  #before_action :validate_rpm

  private

  def authenticate
    authenticate_or_request_with_http_token do |token, options|
      @user = User.where(api_token: token).first
    end
  end

  # NOTE: For ref
  # Manual way of authenticate request
  def authenticate_manual
    api_token = request.headers['X-Api-Key']
    @user = User.where(api_token: api_token).first if api_token

    unless @user
      head status: :unauthorized
      return false
    end
  end

  # Check request per min
  # You can add field to user table request per min or define constant.
  # Here I am just passsing some random value
  def validate_rpm
    if ApiRpmStore.threshold?(@user.id, @user.api_rpm) # 10 request per min
      render json: { help: 'http://mysite.com/plans' }, status: :too_many_requests
      return false
    end
  end

end
