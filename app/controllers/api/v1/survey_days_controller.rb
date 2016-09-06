class Api::V1::SurveyDaysController < Api::ApiController
  before_action :set_survey_day, only: [:show, :update, :destroy]
  after_filter only: [:prefix,:index] { set_pagination_header(:survey_days) }
  
  # GET /survey_days
  def index
    @survey_days = SurveyDay.page params[:page]
     render json: @survey_days
  end

  # GET /survey_days/1
  def show
    render json: @survey_day
  end

  # PATCH/PUT /survey_days/1
  def update
      if @survey_day.update(survey_day_params)
        render json: @survey_day
      else
        render json: @survey_day.errors
      end
  end

  # DELETE /survey_days/1
  def destroy
    @survey_day.destroy
    render json: ''
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_survey_day
    @survey_day = SurveyDay.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def survey_day_params
    params.permit(:expected_patients)
  end

end
