class Api::V1::HcfLocationsController < Api::ApiController
  before_action :set_hcf_location, only: [:show, :update, :destroy]

  # GET /hcf_locations
  # GET /hcf_locations.json
  def index
    @hcf_locations = HcfLocation.page(params[:page]).per(params[:limit])
    render json: @hcf_locations
  end

  # GET /hcf_locations/1
  # GET /hcf_locations/1.json
  def show
    render json: @hcf_location
  end

  # GET /hcf_locations/new
  def new
    @hcf_location = HcfLocation.new
    render json: @hcf_location
  end

  # POST /hcf_locations
  # POST /hcf_locations.json
  def create
    @hcf_location = HcfLocation.new(hcf_location_params)

    if @hcf_location.save
      render json: @hcf_location
    else
      render json: @hcf_location.errors
    end
  end

  # PATCH/PUT /hcf_locations/1
  # PATCH/PUT /hcf_locations/1.json
  def update
    if @hcf_location.update(hcf_location_params)
      render json: @hcf_location
    else
      render json: @hcf_location.errors
    end
  end

  # DELETE /hcf_locations/1
  # DELETE /hcf_locations/1.json
  def destroy
    @hcf_location.destroy
    render json: ''
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_hcf_location
    @hcf_location = HcfLocation.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def hcf_location_params
    params.permit(:address, :phone, :email, :city, :state, :zip, :logo, :user_id, :name, :health_care_facility_id, :image_url)
  end


end
