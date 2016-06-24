class Api::V1::DrugsController < Api::ApiController
  before_action  only: [:show]

  # GET /drugs
  def index
    # @todos = Todo.all
    original_uri = URI.parse(request.original_url)

    uri = URI.parse("https://dplu-preview.data-rx.com/api/v1/drugs")

    if original_uri.query != nil
      original_uri.query.sub! 'name_prefix', 'name%3Aprefix'
      original_uri.query.sub! 'generic_id', 'generic%3Aid'
      original_uri.query.sub! 'therapy-class_id', 'therapy-class%3Aid'

      uri.query = original_uri.query
    end

    response = Net::HTTP.get_response(uri)
    render json: response.body
  end


  # GET /drugs/1
  def show
    uri = URI.join('https://dplu-preview.data-rx.com/api/v1/drugs/', params[:id])
    response = Net::HTTP.get_response(uri)
    render json: response.body
  end

end
