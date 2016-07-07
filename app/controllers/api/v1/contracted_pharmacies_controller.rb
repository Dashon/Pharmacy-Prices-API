class Api::V1::ContractedPharmaciesController < Api::ApiController

  before_action :set_contracted_pharmacy, only: [:show, :update, :destroy]

  # GET /contracted_pharmacies
  def index
    @contracted_pharmacies = ContractedPharmacy.page(params[:page]).per(params[:limit])
    render json: @contracted_pharmacies
  end

  # GET /contracted_pharmacies/1
  def show
    render json: @contracted_pharmacy
  end

  # GET /contracted_pharmacies/new
  def new
    @contracted_pharmacy = ContractedPharmacy.new
    render json: @contracted_pharmacy
  end

  # POST /contracted_pharmacies
  def create
    @contracted_pharmacy = ContractedPharmacy.new(contracted_pharmacy_params)
    if @contracted_pharmacy.save
      render json: @contracted_pharmacy
    else
      render json: @contracted_pharmacy.errors
    end
  end

  # PATCH/PUT /contracted_pharmacies/1
  def update

    if @contracted_pharmacy.update(contracted_pharmacy_params)
      render json: @contracted_pharmacy
    else
      render json: @contracted_pharmacy.errors
    end
  end

  # DELETE /contracted_pharmacies/1
  def destroy
    @contracted_pharmacy.destroy
    render json: ''
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_contracted_pharmacy
    @contracted_pharmacy = ContractedPharmacy.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def contracted_pharmacy_params
    params.require(:contracted_pharmacy).permit(:hcf_pharmacy_id, :user_id)
  end
end
