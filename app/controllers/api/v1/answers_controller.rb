class Api::V1::AnswersController < Api::ApiController
  before_action :set_answer, only: [:show, :update, :destroy]
  after_filter only: [:prefix,:index] { set_pagination_header(:answers) }
  
  # GET /answers
  def index
    @answers = Answer.page params[:page]
     render json: @answers
  end

  # GET /answers/1
  def show
    render json: @answer
  end

  # GET /answers/new
  def new
    @answer = Answer.new
    render json: @answer
  end

  # POST /answers
  def create
    @answer = Answer.new(answer_params)
    if @answer.save
      render json: @answer
    else
      render json: @answer.errors
    end
  end

  # PATCH/PUT /answers/1
  def update
      if @answer.update(answer_params)
        render json: @answer
      else
        render json: @answer.errors
      end
  end

  # DELETE /answers/1
  def destroy
    @answer.destroy
    render json: ''
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_answer
    @answer = Answer.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def answer_params
    params.permit(:user_answer, :question_id, :user_id)
  end

end
