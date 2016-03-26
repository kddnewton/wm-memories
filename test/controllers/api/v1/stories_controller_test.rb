require 'test_helper'

class Api::V1::StoriesControllerTest < ActionController::TestCase

  def setup
    request.headers['Accept'] = Mime[:json]
    request.headers['Content-Type'] = Mime[:json].to_s
  end

  def test_index
    get :index, format: :json
    assert_equal parsed_response, [response_for(:second), response_for(:third)]
  end

  def test_show
    get :show, params: { id: stories(:first).id }
    assert_equal parsed_response, { 'error' => 'Record not found.' }
    assert_response :not_found

    get :show, params: { id: stories(:second).id }
    assert_equal parsed_response, response_for(:second)
  end

  def test_create
    attributes = { body: 'Test', year: 2015, lat: Rails.configuration.x.lat, lng: Rails.configuration.x.lng }
    post :create, params: { story: attributes }
    assert_equal parsed_response.slice('body', 'year', 'lat', 'lng'), attributes.stringify_keys.transform_values(&jsonify)
    assert_response :created
  end

  def test_create_invalid
    post :create, params: { story: { name: '' } }
    assert_equal parsed_response, { 'error' => 'Invalid parameters.' }
    assert_response :bad_request
  end

  private

    # transform the values for a json
    def jsonify
      @jsonify ||= Proc.new do |value|
        case value
        when Time then value.to_json[1..-2]
        when BigDecimal, Float then value.to_s
        else value
        end
      end
    end

    # the parsed JSON response
    def parsed_response
      JSON.parse(response.body)
    end

    # build a response for the given fixture
    def response_for(fixture)
      stories(fixture).attributes.slice(*%w[id year body created_at updated_at lat lng]).transform_values(&jsonify)
    end
end
