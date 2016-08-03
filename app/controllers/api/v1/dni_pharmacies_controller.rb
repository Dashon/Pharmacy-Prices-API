class Api::V1::DniPharmaciesController < Api::ApiController
  before_action :set_dni_pharmacy, only: [:show, :update, :destroy]
  after_filter only: [:prefix,:index] { set_pagination_header(:dni_pharmacies) }

  # GET /dni_pharmacies
  # GET /dni_pharmacies.json
  def index
    @dni_pharmacies = DniPharmacy.page(params[:page]).per(params[:limit])
    render json: @dni_pharmacies
  end


  # GET /dni_pharmacies/prefix
  def prefix
    if params[:query].length >= 3
      t = DniPharmacy.arel_table
      @dni_pharmacies = DniPharmacy.where(t[:name].matches("#{params[:query]}%")).or(DniPharmacy.where(short_code: (params[:query].upcase))).or(DniPharmacy.where(t[:address].matches("#{params[:query]}%"))).page(params[:page]).per(params[:limit])
      render json: @dni_pharmacies
    else
      render json: '{"name":"Minimum 3 Characters"}'
    end
  end

  # GET /dni_pharmacies/1
  # GET /dni_pharmacies/1.json
  def show
    render json: @dni_pharmacy
  end

  # GET /dni_pharmacies/new
  def new
    @dni_pharmacy = DniPharmacy.new
    render json: @dni_pharmacy
  end


  # POST /dni_pharmacies
  def create
    @dni_pharmacy = DniPharmacy.new(dni_pharmacy_params)

    if @dni_pharmacy.save
      render json: @dni_pharmacy
    else
      render json: @dni_pharmacy.errors
    end
  end

  # PATCH/PUT /dni_pharmacies/1
  def update
    if @dni_pharmacy.update(dni_pharmacy_params)
      render json: @dni_pharmacy
    else
      render json: @dni_pharmacy.errors
    end
  end

  # DELETE /dni_pharmacies/1
  def destroy
    @dni_pharmacy.destroy
    render json: ''
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_dni_pharmacy
    @dni_pharmacy = DniPharmacy.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def dni_pharmacy_params
    params.permit(:name ,:address, :phone, :email, :city, :state, :zip, :latitude, :longitude, :matchScore, :user_id, :surescriptsId, :stateListId, :npi)
  end
end
