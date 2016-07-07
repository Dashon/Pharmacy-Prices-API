class Api::V1::UsersController < Api::ApiController
  before_action :authenticate_user!
  before_action :admin_only, :except => :show
  after_filter only: [:prefix,:index] { set_pagination_header(:users) }

  def index
    @users = User.page(params[:page]).per(params[:limit])
    unless current_user.admin?
      render json: @user
    end
    render json: @users
  end

  def show
    @user = User.find(params[:id])
    if current_user.admin? || @user == current_user
      render json: @user
    else
      render json: '"unauthorized"' ,:status => :unauthorized
    end
  end

  def update
    @user = User.find(params[:id])
    if current_user.admin? || @user == current_user
      if @user.update_attributes(secure_params)
        render json: @user
      else
        render json: @user.errors
      end
    end
  end


  def unassociate
    @user = User.find(params[:id])
    if current_user.admin? || @user == current_user
       @user.health_care_facility = nil
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    render json: ''
  end

  private

  def admin_only
    unless current_user.admin?
      render json: "Access denied."
    end
  end

  def secure_params
    params.require(:user).permit(:role, :name, :email, :password)
  end

end
