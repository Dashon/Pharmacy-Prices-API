class Api::V1::PharmaciesController < Api::ApiController
  before_action only: [:show]

  # GET /pharmacies
  def index
    # @todos = Todo.all
    original_uri = URI.parse(request.original_url)

    uri = URI.parse("https://dplu-preview.data-rx.com/api/v1/pharmacies")

    if original_uri.query != nil
      original_uri.query.sub! 'distance_miles_max', 'distance%3Amiles%3Amax'
      original_uri.query.sub! 'distance_from_zip', 'distance%3Afrom%3Azip'

      uri.query = original_uri.query
    end

    response = Net::HTTP.get_response(uri)
    render json: response.body
  end


  # GET /pharmacies/1
  def show
    uri = URI.join('https://dplu-preview.data-rx.com/api/v1/pharmacies/', params[:id])
    response = Net::HTTP.get_response(uri)
    render json: response.body
  end

  private
  # Only allow a trusted parameter "white list" through.
  def pharmacy_params
    params.require(:pharmacy).permit(:distance_miles_max, :distance_from_zip)
  end
end
