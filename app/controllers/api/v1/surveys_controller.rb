class Api::V1::SurveysController < Api::ApiController
  before_action :set_survey, only: [:show, :update, :destroy]
  after_filter only: [:prefix,:index] { set_pagination_header(:surveys) }

  # GET /surveys
  def index
    @surveys = Survey.page(params[:page]).per(params[:limit])
    render json: @surveys
  end

  # GET /surveys/1
  def show
    render json: @survey
  end

  # GET /surveys/new
  def new
    @survey = Survey.new
    render json: @survey
  end

  # POST /surveys
  # POST /surveys.json
  def create
    @survey = Survey.new(survey_params)
   if @survey.save
    params[:answers].each do |answer|
      answer['survey_id'] = @survey.id
      answer = Answer.new(answer.json)
      nanswer.save
    end
      render json: @survey
    else
      render json: @survey.errors
    end
  end

  # PATCH/PUT /surveys/1
  def update
    if @survey.update(survey_params)
      render json: @survey
    else
      render json: @survey.errors
    end
  end

  # DELETE /surveys/1
  def destroy
    @survey.destroy
    render json: ''
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_survey
    @survey = Survey.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def survey_params
    params.permit(:survey_type, :health_care_facility_id, :user_id, :answers)
  end
end
