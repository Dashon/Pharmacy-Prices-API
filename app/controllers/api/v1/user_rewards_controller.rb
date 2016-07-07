class Api::V1::UserRewardsController < Api::ApiController
  before_action :set_user_reward, only: [:show, :update, :destroy]
  after_filter only: [:prefix,:index] { set_pagination_header(:user_rewards) }

  # GET /user_rewards
  def index
    @user_rewards = UserReward.page(params[:page]).per(params[:limit])
    render json: @user_rewards
  end

  # GET /user_rewards/1
  def show
    render json: @user_reward
  end

  # GET /user_rewards/new
  def new
    @user_reward = UserReward.new
    render json: @user_reward
  end

  # POST /user_rewards
  def create
    @user_reward = UserReward.new(user_reward_params)

    if @user_reward.save
      render json: @user_reward
    else
      render json: @user_reward.errors
    end
  end

  # PATCH/PUT /user_rewards/1
  def update
    if @user_reward.update(user_reward_params)
      render json: @user_reward
    else
      render json: @user_reward.errors
    end
  end

  # DELETE /user_rewards/1
  def destroy
    @user_reward.destroy
    render json: ''
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user_reward
    @user_reward = UserReward.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_reward_params
    params.require(:user_reward).permit(:hcf_reward_id, :user_id, :redeemed)
  end
end
