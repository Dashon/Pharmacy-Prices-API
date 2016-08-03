class Api::V1::UsersController < Api::ApiController
  after_filter only: [:prefix,:index] { set_pagination_header(:users) }

  def index
    result = current_user
    if current_user.doc_and_i_admin?
      @users = User.page(params[:page]).per(params[:limit])
      result = @users
    elsif current_user.team_admin?
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

  def isAdmin
    render json: '{"isAdmin":' + (current_user.doc_and_i_admin? ? "true" : "false" ) + '}'
  end

  def update
    @user = User.find(params[:id])
    if @user == current_user
      @user.update_attributes(secure_params)
    end

    if !params[:health_care_facility_id] && !@user.health_care_facility_id
      params[:health_care_facility_id] = current_user.health_care_facility_id
    end

    if @user.doc_and_i_admin? && params[:role] && params[:role] != 18650
      return render json: '"cannot change admin role"' ,:status => :unauthorized
    end

    if current_user.doc_and_i_admin?
      @user.update_attributes(admin_params)
    elsif (current_user.team_admin? && current_user.health_care_facility_id == @user.health_care_facility_id)
      unless params[:role] == 18650
        @user.update_attributes(role_params)
      end
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

    allRoles =  User.roles.select{|key, hash| key == current_user.role}

    if current_user.team_admin?
      allRoles = User.roles.select{|key, hash| key != 'doc_and_i_admin' && key != 'api_user' }
    elsif current_user.doc_and_i_admin?
      allRoles = User.roles
    end

    render json: allRoles
  end

  private

  def admin_params
    params.require(:user).permit(:name, :role,:email,:password, :health_care_facility_id, :image_url)
  end

  def secure_params
    params.require(:user).permit(:name, :image_url)
  end


  def role_params
    params.require(:user).permit(:role)
  end

end
