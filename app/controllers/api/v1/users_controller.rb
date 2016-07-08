class Api::V1::UsersController < Api::ApiController
  before_action :authenticate_request!
  before_action :admin_only, :except => [:show,:roles]
  after_filter only: [:prefix,:index] { set_pagination_header(:users) }

  def index
    @users = User.page(params[:page]).per(params[:limit])
    unless current_user.doc_and_i_admin?
      render json: @user
    end
    render json: @users
  end

  def show
    @user = User.find(params[:id])
    if current_user.doc_and_i_admin? || @user == current_user
      render json: @user
    else
      render json: '"unauthorized"' ,:status => :unauthorized
    end
  end

  def update
    @user = User.find(params[:id])
    if current_user.doc_and_i_admin? || @user == current_user
      if @user.update_attributes(secure_params)
        render json: @user
      else
        render json: @user.errors
      end
    end
  end


  def unassociate
    @user = User.find(params[:id])
    if current_user.doc_and_i_admin? || @user == current_user
      @user.health_care_facility_id = nil
      @user.save
    end
    render json: @user
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    render json: ''
  end

  def roles
    allRoles = User.roles
    unless current_user.doc_and_i_admin?
      allRoles = User.roles.select{|key, hash| key != "doc_and_i_admin" || "api_user" }
    end
    render json: allRoles
  end

  private

  def admin_only
    unless current_user.doc_and_i_admin?
      render json: "Access denied."
    end
  end

  def secure_params
    params.require(:user).permit(:role, :name, :email, :password)
  end

end
