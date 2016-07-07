class Api::V1::PharmacyEditRequestsController < Api::ApiController
  before_action :set_pharmacy_edit_request, only: [:show, :update, :destroy]
  after_filter only: [:prefix,:index] { set_pagination_header(:pharmacy_edit_requests) }

  # GET /pharmacy_edit_requests
  # GET /pharmacy_edit_requests.json
  def index
    @pharmacy_edit_requests = PharmacyEditRequest.page(params[:page]).per(params[:limit])
    render json: @pharmacy_edit_requests
  end

  # GET /pharmacy_edit_requests/1
  # GET /pharmacy_edit_requests/1.json
  def show

  end

  # GET /pharmacy_edit_requests/new
  def new
    @pharmacy_edit_request = PharmacyEditRequest.new
    render json: @pharmacy_edit_request
  end


  # POST /pharmacy_edit_requests
  def create
    @pharmacy_edit_request = PharmacyEditRequest.new(pharmacy_edit_request_params)
    if @pharmacy_edit_request.save
      render json: @pharmacy_edit_request
    else
      render json: @pharmacy_edit_request.errors
    end
  end

  # PATCH/PUT /pharmacy_edit_requests/1
  def update
    if @pharmacy_edit_request.update(pharmacy_edit_request_params)
      render json: @pharmacy_edit_request
    else
      render json: @pharmacy_edit_request.errors
    end
  end

  # DELETE /pharmacy_edit_requests/1
  def destroy
    @pharmacy_edit_request.destroy
    render  json: ''
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_pharmacy_edit_request
    @pharmacy_edit_request = PharmacyEditRequest.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def pharmacy_edit_request_params
    params.permit(:name, :address, :phone, :email, :city, :state, :zip, :latitude, :longitude, :surescripts_id, :stateList_id, :dni_pharmacy_id, :approved, :user_id,)
  end
end
