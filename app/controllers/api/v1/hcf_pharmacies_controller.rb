class Api::V1::HcfPharmaciesController < Api::ApiController
  before_action :set_hcf_pharmacy, only: [:show, :update, :destroy]
  # after_filter only: [:prefix,:index] { set_pagination_header(:hcf_pharmacies) }

  # GET /hcf_pharmacies/list
  def list
    @hcf_pharmacies = HcfPharmacy.where(health_care_facility_id: params[:health_care_facility_id]).page(params[:page]).per(params[:limit])
    render json: @hcf_pharmacies
  end

  # GET /hcf_pharmacies/prefix
  def prefix
    if params[:query].length >= 3
      t = HcfPharmacy.arel_table
      @hcf_pharmacies = HcfPharmacy.joins(:dni_pharmacy).where(DniPharmacy.arel_table[:name].matches("#{params[:query]}%")).or(HcfPharmacy.joins(:dni_pharmacy).where(DniPharmacy.arel_table[:short_code].eq((params[:query]).upcase))).or(HcfPharmacy.joins(:dni_pharmacy).where(DniPharmacy.arel_table[:address].matches("#{params[:query]}%"))).page(params[:page]).per(params[:limit])
      render json: @hcf_pharmacies
    else
      render json: '"{"name":"Minimum 3 Characters"}"'
    end
  end

  # GET /hcf_pharmacies/1
  # GET /hcf_pharmacies/1.json
  def show
    render json: @hcf_pharmacy
  end

  # GET /hcf_pharmacies/new
  def new
    @hcf_pharmacy = HcfPharmacy.new
    render json: @hcf_pharmacy
  end

  # POST /hcf_pharmacies
  def create
    @hcf_pharmacy = HcfPharmacy.new(hcf_pharmacy_params)
    if @hcf_pharmacy.save
      render json: @hcf_pharmacy
    else
      render json: @hcf_pharmacy.errors
    end
  end

  # PATCH/PUT /hcf_pharmacies/1
  def update
    if @hcf_pharmacy.update(hcf_pharmacy_params)
      render json: @hcf_pharmacy
    else
      render json: @hcf_pharmacy.errors
    end
  end

  # DELETE /hcf_pharmacies/1
  def destroy
    @hcf_pharmacy.destroy
    render json: ''
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_hcf_pharmacy
    @hcf_pharmacy = HcfPharmacy.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def hcf_pharmacy_params
    params.permit(:externalId, :health_care_facility_id, :dni_pharmacy_id)
  end
end
