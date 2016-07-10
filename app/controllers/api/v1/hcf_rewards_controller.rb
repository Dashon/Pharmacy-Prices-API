class Api::V1::HcfRewardsController < Api::ApiController
  before_action :set_hcf_reward, only: [:show, :update, :destroy]
  after_filter only: [:prefix,:index] { set_pagination_header(:hcf_rewards) }

  # GET /hcf_rewards
  # GET /hcf_rewards.json
  def index
    @hcf_rewards = HcfReward.page(params[:page]).per(params[:limit])
    render json: @hcf_rewards
  end

  # GET /hcf_rewards/1
  def show
    render json: @hcf_reward
  end

  # GET /hcf_rewards/new
  def new
    @hcf_reward = HcfReward.new
    render json: @hcf_reward
  end

  # POST /hcf_rewards
  def create
    @hcf_reward = HcfReward.new(hcf_reward_params)
    if @hcf_reward.save
      render json: @hcf_reward
    else
      render json: @hcf_reward.errors
    end
  end

  # PATCH/PUT /hcf_rewards/1
  def update
    if @hcf_reward.update(hcf_reward_params)
      render json: @hcf_reward
    else
      render json: @hcf_reward.errors
    end
  end

  # DELETE /hcf_rewards/1
  def destroy
    @hcf_reward.destroy
    render json: ''
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_hcf_reward
    @hcf_reward = HcfReward.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def hcf_reward_params
    params.require(:hcf_reward).permit(:reward_id, :health_care_facility_id, :user_id, :image_url)
  end
end
