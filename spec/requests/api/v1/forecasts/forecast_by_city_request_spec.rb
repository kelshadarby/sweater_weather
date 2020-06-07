require 'rails_helper'

RSpec.describe "Forecast Request" do
  describe "Forecast By City" do
    it "Upper Left Box", :vcr do
      get "/api/v1/forecast?location=denver,co"

      expect(response).to be_successful

      parsed_forecast = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_forecast[:data][:attributes][:location_info][:city]).to_not eq(nil)
      expect(parsed_forecast[:data][:attributes][:location_info][:state]).to_not eq(nil)
      expect(parsed_forecast[:data][:attributes][:location_info][:country]).to_not eq(nil)
      expect(parsed_forecast[:data][:attributes][:current_time_month_day]).to_not eq(nil)
      expect(parsed_forecast[:data][:attributes][:weather_description]).to_not eq(nil)
      expect(parsed_forecast[:data][:attributes][:actual_temp]).to_not eq(nil)
      expect(parsed_forecast[:data][:attributes][:high_temp]).to_not eq(nil)
      expect(parsed_forecast[:data][:attributes][:low_temp]).to_not eq(nil)
    end

    it "Upper Left Box", :vcr do
      get "/api/v1/forecast?location=denver,co"

      expect(response).to be_successful

      parsed_forecast = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_forecast[:data][:attributes][:weather_description]).to_not eq(nil)
      expect(parsed_forecast[:data][:attributes][:feels_like]).to_not eq(nil)
      expect(parsed_forecast[:data][:attributes][:humidity]).to_not eq(nil)
      expect(parsed_forecast[:data][:attributes][:uv_index]).to_not eq(nil)
      expect(parsed_forecast[:data][:attributes][:sunrise_time]).to_not eq(nil)
      expect(parsed_forecast[:data][:attributes][:sunset_time]).to_not eq(nil)
    end

    it "Lower Box, Today", :vcr do
      get "/api/v1/forecast?location=denver,co"

      expect(response).to be_successful

      parsed_forecast = JSON.parse(response.body, symbolize_names: true)

      keys = [:hour_one, :hour_two, :hour_three, :hour_four, :hour_five, :hour_six, :hour_seven, :hour_eight]

      keys.each do |key|
        expect(parsed_forecast[:data][:attributes][:hourly_weather_forecast][key]).to have_key(:time)
        expect(parsed_forecast[:data][:attributes][:hourly_weather_forecast][key]).to have_key(:temp)
        expect(parsed_forecast[:data][:attributes][:hourly_weather_forecast][key]).to have_key(:description)

        expect(parsed_forecast[:data][:attributes][:hourly_weather_forecast][key][:time]).to_not eq(nil)
        expect(parsed_forecast[:data][:attributes][:hourly_weather_forecast][key][:temp]).to_not eq(nil)
        expect(parsed_forecast[:data][:attributes][:hourly_weather_forecast][key][:description]).to_not eq(nil)
      end

    end

    it "Lower Box, Week", :vcr do
      get "/api/v1/forecast?location=denver,co"

      expect(response).to be_successful

      parsed_forecast = JSON.parse(response.body, symbolize_names: true)

      weekly_forecast_keys = [:day_one, :day_two, :day_three, :day_four, :day_five, :day_six]

      weekly_forecast_keys.each do |key|
        expect(parsed_forecast[:data][:attributes][:week_weather_forecast][key]).to have_key(:day_of_week)
        expect(parsed_forecast[:data][:attributes][:week_weather_forecast][key]).to have_key(:description)
        expect(parsed_forecast[:data][:attributes][:week_weather_forecast][key]).to have_key(:precipitation)
        expect(parsed_forecast[:data][:attributes][:week_weather_forecast][key]).to have_key(:high_temp)
        expect(parsed_forecast[:data][:attributes][:week_weather_forecast][key]).to have_key(:low_temp)

        expect(parsed_forecast[:data][:attributes][:week_weather_forecast][key][:day_of_week]).to_not eq(nil)
        expect(parsed_forecast[:data][:attributes][:week_weather_forecast][key][:description]).to_not eq(nil)
        expect(parsed_forecast[:data][:attributes][:week_weather_forecast][key][:precipitation]).to_not eq(nil)
        expect(parsed_forecast[:data][:attributes][:week_weather_forecast][key][:high_temp]).to_not eq(nil)
        expect(parsed_forecast[:data][:attributes][:week_weather_forecast][key][:low_temp]).to_not eq(nil)
      end
    end
  end
  describe "Forecast Background Images by City", :vcr do
    it "Background Image Request" do
      get "/api/v1/backgrounds?location=denver,co"

      expect(response).to be_successful

      parsed_background = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_background[:data][:attributes][:image]).to_not eq(nil)
    end
  end
end
