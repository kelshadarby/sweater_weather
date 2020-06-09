require 'rails_helper'

RSpec.describe "Road Trip Request" do
  before :each do
    user_params = {
      "email": "whatever@example.com",
      "password": "password",
      "password_confirmation": "password"
    }
    post "/api/v1/users", params: {user: user_params}

    user_params = {
      "email": "whatever@example.com",
      "password": "password"
    }
    post "/api/v1/sessions", params: {user: user_params}

    expect(response).to be_successful

    @user_info = JSON.parse(response.body, symbolize_names: true)
  end
  it "Destination Forecast and Road Trip Info" do
    road_trip_params = {
      "origin": "Denver,CO",
      "destination": "Pueblo,CO",
      "api_key": @user_info[:data][:attributes][:api_key]
    }
    get '/api/v1/road_trip', params: {road_trip: road_trip_params}

    expect(response).to be_successful

    parsed_road_trip_response = JSON.parse(response.body, symbolize_names: true)

    expect(parsed_road_trip_response).to have_key(:data)
    expect(parsed_road_trip_response[:data]).to have_key(:id)
    expect(parsed_road_trip_response[:data]).to have_key(:type)
    expect(parsed_road_trip_response[:data]).to have_key(:attributes)
    expect(parsed_road_trip_response[:data][:attributes]).to have_key(:origin)
    expect(parsed_road_trip_response[:data][:attributes]).to have_key(:destination)
    expect(parsed_road_trip_response[:data][:attributes]).to have_key(:travel_time)
    expect(parsed_road_trip_response[:data][:attributes]).to have_key(:arrival_forecast)
    expect(parsed_road_trip_response[:data][:attributes]).to have_key(:travel_time)

    expect(parsed_road_trip_response[:data]).to_not eq(nil)
    expect(parsed_road_trip_response[:data][:id]).to_not eq(nil)
    expect(parsed_road_trip_response[:data][:type]).to_not eq(nil)
    expect(parsed_road_trip_response[:data][:attributes]).to_not eq(nil)
    expect(parsed_road_trip_response[:data][:attributes][:origin]).to_not eq(nil)
    expect(parsed_road_trip_response[:data][:attributes][:destination]).to_not eq(nil)
    expect(parsed_road_trip_response[:data][:attributes][:travel_time]).to_not eq(nil)
    expect(parsed_road_trip_response[:data][:attributes][:arrival_forecast]).to_not eq(nil)
    expect(parsed_road_trip_response[:data][:attributes][:travel_time]).to_not eq(nil)

    expect(parsed_road_trip_response[:data][:type]).to eq("road_trip")
    expect(parsed_road_trip_response[:data][:id]).to eq("null")
    expect(parsed_road_trip_response[:data][:attributes][:origin]).to eq(road_trip_params[:origin])
    expect(parsed_road_trip_response[:data][:attributes][:destination]).to eq(road_trip_params[:destination])
    expect(parsed_road_trip_response[:data][:attributes][:travel_time]).to eq("1 hour 48 mins")
  end
  it "Destination Forecast and Road Trip Info - Invalid API Key" do
    road_trip_params = {
      "origin": "Denver,CO",
      "destination": "Pueblo,CO",
      "api_key": "abc123"
    }
    get '/api/v1/road_trip', params: {road_trip: road_trip_params}

    expect(response).to_not be_successful

    parsed_road_trip_response = JSON.parse(response.body, symbolize_names: true)

    expect(parsed_road_trip_response[:errors]).to eq("Invalid API Key")
    expect(response.status).to eq(401)
  end
  it "Destination Forecast and Road Trip Info - No API Key" do
    road_trip_params = {
      "origin": "Denver,CO",
      "destination": "Pueblo,CO"
    }
    get '/api/v1/road_trip', params: {road_trip: road_trip_params}

    expect(response).to_not be_successful

    parsed_road_trip_response = JSON.parse(response.body, symbolize_names: true)

    expect(parsed_road_trip_response[:errors]).to eq("API Key is Required")
    expect(response.status).to eq(401)
  end
end
