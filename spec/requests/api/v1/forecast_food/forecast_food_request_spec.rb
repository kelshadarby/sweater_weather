require 'rails_helper'

RSPec.describe "Forecast Food Request" do
  it "Destination Forecast and Food Request" do
    get '/api/v1/foodie?start=denver,co&end=pueblo,co&search=italian'

    expect(response).to be_successful

    parsed_food_response = JSON.parse(response.body, symbolize_names: true)

    expect(parsed_food_response).to have_key(:data)
    expect(parsed_food_response[:data]).to have_key(:id)
    expect(parsed_food_response[:data]).to have_key(:type)
    expect(parsed_food_response[:data]).to have_key(:attributes)
    expect(parsed_food_response[:data][:attributes]).to have_key(:end_location)
    expect(parsed_food_response[:data][:attributes]).to have_key(:travel_time)
    expect(parsed_food_response[:data][:attributes]).to have_key(:forecast)
    expect(parsed_food_response[:data][:attributes]).to have_key(:restaurant)
    expect(parsed_food_response[:data][:attributes][:forecast]).to have_key(:summary)
    expect(parsed_food_response[:data][:attributes][:forecast]).to have_key(:temperature)
    expect(parsed_food_response[:data][:attributes][:restaurant]).to have_key(:name)
    expect(parsed_food_response[:data][:attributes][:restaurant]).to have_key(:address)

    expect(parsed_food_response[:data][:id]).to eq("null")
    expect(parsed_food_response[:data][:type]).to eq("foodie")
    expect(parsed_food_response[:data]).to_not eq(nil)
    expect(parsed_food_response[:data][:id]).to_not eq(nil)
    expect(parsed_food_response[:data][:type]).to_not eq(nil)
    expect(parsed_food_response[:data][:attributes]).to_not eq(nil)
    expect(parsed_food_response[:data][:attributes][:end_location]).to_not eq(nil)
    expect(parsed_food_response[:data][:attributes][:travel_time]).to_not eq(nil)
    expect(parsed_food_response[:data][:attributes][:forecast]).to_not eq(nil)
    expect(parsed_food_response[:data][:attributes][:restaurant]).to_not eq(nil)
    expect(parsed_food_response[:data][:attributes][:forecast][:summary]).to_not eq(nil)
    expect(parsed_food_response[:data][:attributes][:forecast][:temperature]).to_not eq(nil)
    expect(parsed_food_response[:data][:attributes][:restaurant][:name]).to_not eq(nil)
    expect(parsed_food_response[:data][:attributes][:restaurant][:address]).to_not eq(nil)
  end
end
