class Api::V1::QuestionsController < Api::ApiController
  before_action :set_question, only: [:show, :update, :destroy]
  after_filter only: [:prefix,:index] { set_pagination_header(:questions) }

  # GET /questions
  # GET /questions.json
  def index
    @questions = Question.page(params[:page]).per(params[:limit])
    render json: @questions
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
    render json: @question
  end

  # GET /questions/new
  def new
    @question = Question.new
    render json: @question
  end

  # POST /questions
  def create
    @question = Question.new(question_params)
    if @question.save
      render json: @question
    else
      render json: @question.errors
    end
  end

  # PATCH/PUT /questions/1
  def update
    if @question.update(question_params)
      render json: @question
    else
      render json: @question.errors
    end
  end

  # DELETE /questions/1
  def destroy
    @question.destroy
    render  json: ''
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_question
    @question = Question.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def question_params
    params.require(:question).permit(:name, :description, :value, :survey_id)
  end
end
