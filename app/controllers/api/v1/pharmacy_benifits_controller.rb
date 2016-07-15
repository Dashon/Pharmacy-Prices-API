class PharmacyBenifitsController < ApplicationController
  before_action :set_pharmacy_benifit, only: [:show, :edit, :update, :destroy]

  # GET /pharmacy_benifits
  # GET /pharmacy_benifits.json
  def index
    @pharmacy_benifits = PharmacyBenifit.all
  end

  # GET /pharmacy_benifits/1
  # GET /pharmacy_benifits/1.json
  def show
  end

  # GET /pharmacy_benifits/new
  def new
    @pharmacy_benifit = PharmacyBenifit.new
  end

  # GET /pharmacy_benifits/1/edit
  def edit
  end

  # POST /pharmacy_benifits
  # POST /pharmacy_benifits.json
  def create
    @pharmacy_benifit = PharmacyBenifit.new(pharmacy_benifit_params)

    respond_to do |format|
      if @pharmacy_benifit.save
        format.html { redirect_to @pharmacy_benifit, notice: 'Pharmacy benifit was successfully created.' }
        format.json { render :show, status: :created, location: @pharmacy_benifit }
      else
        format.html { render :new }
        format.json { render json: @pharmacy_benifit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pharmacy_benifits/1
  # PATCH/PUT /pharmacy_benifits/1.json
  def update
    respond_to do |format|
      if @pharmacy_benifit.update(pharmacy_benifit_params)
        format.html { redirect_to @pharmacy_benifit, notice: 'Pharmacy benifit was successfully updated.' }
        format.json { render :show, status: :ok, location: @pharmacy_benifit }
      else
        format.html { render :edit }
        format.json { render json: @pharmacy_benifit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pharmacy_benifits/1
  # DELETE /pharmacy_benifits/1.json
  def destroy
    @pharmacy_benifit.destroy
    respond_to do |format|
      format.html { redirect_to pharmacy_benifits_url, notice: 'Pharmacy benifit was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pharmacy_benifit
      @pharmacy_benifit = PharmacyBenifit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pharmacy_benifit_params
      params.require(:pharmacy_benifit).permit(:benefit_id, :dniPharmacy_id)
    end
end
