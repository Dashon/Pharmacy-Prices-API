class Api::V1::PeopleController < Api::ApiController
  before_action :set_person, only: [:show, :update, :destroy]

  # GET /people
  def index
    @people = Person.all
    render json: @people
  end

  # GET /people/1
  def show
    render json: @person
  end

  # GET /people/new
  def new
    @person = Person.new
    render json: @person
  end

  # POST /people
  def create
    @person = Person.new(person_params)
    if @person.save
      render json: @person
    else
      render json: @person.errors
    end
  end

  # PATCH/PUT /people/1
  def update
    if @person.update(person_params)
      render json: @person
    else
      render json: @person.errors
    end
  end

  # DELETE /people/1
  def destroy
    @person.destroy

    render  json: ''
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_person
    @person = Person.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def person_params
    params.require(:person).permit(:name, :address, :city, :state, :zip, :user_id)
  end
end
