class Api::V1::DrugPricesController < Api::ApiController
  before_action only: [:index]

  # GET /drug_prices
  def index
    # @todos = Todo.all
    original_uri = URI.parse(request.original_url)

    uri = URI.parse("https://dplu-preview.data-rx.com/api/v1/drug-prices")

    if original_uri.query != nil
      original_uri.query.sub! 'days_supply', 'days%3Asupply'
      original_uri.query.sub! 'generic_id', 'generic%3Aid'
      uri.query = original_uri.query
    end

    response = Net::HTTP.get_response(uri)
    render json: response.body
  end


  private

  # Only allow a trusted parameter "white list" through.
  def drug_price_params
    params.require(:drug_price).permit(:days_supply, :quantity, :generic_id, :ndc11)
  end
end
