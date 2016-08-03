class Api::V1::HealthCareFacilitiesController < Api::ApiController
  before_action :set_health_care_facility, only: [:show, :update, :destroy,:pharmacies, :contracted,:map,:seed_clinic]
  after_filter only: [:index] { set_pagination_header(:health_care_facilities) }

  # GET /health_care_facilities
  def index
    @health_care_facilities = HealthCareFacility.page(params[:page]).per(params[:limit])
    render json: @health_care_facilities
  end

  # GET /health_care_facilities/1
  def show
    render json: @health_care_facility
  end

  # GET /health_care_facilities/new
  def new
    @health_care_facility = HealthCareFacility.new
    render json: @health_care_facility
  end

  # POST /health_care_facilities
  def create
    @health_care_facility = HealthCareFacility.new(health_care_facility_params)
    if @health_care_facility.save
      render json: @health_care_facility
    else
      render json: @health_care_facility.errors
    end
  end

  # PATCH/PUT /health_care_facilities/1
  def update
    if @health_care_facility.update(health_care_facility_params)
      render json: @health_care_facility
    else
      render json: @health_care_facility.errors
    end
  end

  # DELETE /health_care_facilities/1
  def destroy
    @health_care_facility.destroy
    render json: ''
  end

  def pharmacies
    render json: @health_care_facility.pharmacies
  end

  def contracted
    render json: @health_care_facility.contracted.map{|x|
      x.contracted = true
    x}
  end

  def seed_clinic
 
    render json: @health_care_facility
  end

  def map
    render json: ((@health_care_facility.contracted.map{|x|
                     x.contracted = true
    x})+(@health_care_facility.pharmacies)).uniq
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_health_care_facility
    @health_care_facility = HealthCareFacility.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def health_care_facility_params
    params.permit(:name, :address, :phone, :city, :state, :zip, :image_url, :user_id)
  end
end
