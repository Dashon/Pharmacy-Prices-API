class Api::V1::UsersController < Api::ApiController
  before_action :authenticate_request!
  before_action :admin_only, :except => [:show,:roles]
  after_filter only: [:prefix,:index] { set_pagination_header(:users) }

  def index
    result = "{'error':'No Users'}"
    if current_user.doc_and_i_admin?
      @users = User.page(params[:page]).per(params[:limit])
      result =@users

    end

    if current_user.team_admin?
      @users = User.where(:health_care_facility_id  == current_user.health_care_facility_id).page(params[:page]).per(params[:limit])
      result = @users
    end

    render json: result

  end

  def show
    @user = User.find(params[:id])
    if current_user.doc_and_i_admin? || @user == current_user || current_user.health_care_facility_id == @user.health_care_facility_id
      render json: @user
    else
      render json: '"unauthorized"' ,:status => :unauthorized
    end
  end

  def update
    @user = User.find(params[:id])
    if @user == current_user
      @user.update_attributes(secure_params)
    elsif current_user.doc_and_i_admin? || (current_user.team_admin? && current_user.health_care_facility_id == @user.health_care_facility_id)
      @user.update_attributes(role_params)
    end

    if @user.valid?
      render json: @user
    else
      render json: @user.errors
    end
  end


  def unassociate
    @user = User.find(params[:id])
    if current_user.doc_and_i_admin?  || (current_user.team_admin? && current_user.health_care_facility_id == @user.health_care_facility_id)
      @user.health_care_facility_id = nil
      @user.save
    end
    render json: @user
  end


  def roles
    if @user == current_user
      allRoles = current_user.role
    end

    if current_user.team_admin?
      allRoles = User.roles.select{|key, hash| key != "doc_and_i_admin" || "api_user" }
    elsif current_user.doc_and_i_admin?
      allRoles = User.roles
    end

    render json: allRoles
  end

  private

  def admin_only
    unless current_user.doc_and_i_admin?
      render json: '"unauthorized"' ,:status => :unauthorized

    end
  end

  def secure_params
    params.require(:user).permit(:name)
  end


  def role_params
    params.require(:user).permit(:role)
  end

end
