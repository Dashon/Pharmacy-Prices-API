class Api::V1::RewardsController < Api::ApiController
  before_action :set_reward, only: [:show, :update, :destroy]
  after_filter only: [:prefix,:index] { set_pagination_header(:rewards) }
  before_action :admin_only

  # GET /rewards
  # GET /rewards.json
  def index
    @rewards = Reward.page(params[:page]).per(params[:limit])
    render json: @rewards
  end

  # GET /rewards/1
  # GET /rewards/1.json
  def show
    render json: @reward
  end

  # GET /rewards/new
  def new
    @reward = Reward.new
    render json: @reward
  end

  # POST /rewards
  def create
    @reward = Reward.new(reward_params)
    if @reward.save
      render json: @reward
    else
      render json: @reward.errors
    end
  end

  # PATCH/PUT /rewards/1
  def update
    if @reward.update(reward_params)
      render json: @reward
    else
      render json: @reward.errors
    end
  end

  # DELETE /rewards/1
  def destroy
    @reward.destroy
    render  json: ''
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_reward
    @reward = Reward.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def reward_params
    params.permit(:name, :reward_type, :cost, :description, :user_id)
  end
end
