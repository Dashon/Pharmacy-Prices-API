require 'rubygems' # not necessary with ruby 1.9 but included for completeness
require 'twilio-ruby' # put your own credentials here


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
    @survey = Survey.new
    @survey.user_id = params[:user_id] || current_user.id
    @survey.health_care_facility_id = current_user.health_care_facility_id
    @survey.survey_type = "340B"
    @survey.survey_day_id = current_user.survey_day.id

    if @survey.save
      params[:answers].each do |answer|
        newAnswer = Answer.new
        newAnswer.user_answer = answer['user_answer']
        newAnswer.question_id = answer['question_id']
        newAnswer.survey_id = @survey.id
        newAnswer.save
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

  def text_patient
    account_sid = 'ACf22a16691c23c07d398c63a1a583e051'
    auth_token = '52663079febd22dbb8f8d3971ba1f216'
    @client = Twilio::REST::Client.new account_sid, auth_token
    pharmacy = ContractedPharmacy.find(params[:contrated_pharamcy_id])

    message = @client.account.messages.create({
                                                :to => params[:contact_info],
                                                :from => '+17082403776',
                                                :body => "Hello, Your new Pharmacy is: " +  pharmacy.dni_pharmacy.display_name,
    })

    render json: "{'result':'Sent'}"
  end

  def email_patient

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
