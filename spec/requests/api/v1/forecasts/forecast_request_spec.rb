require 'rails_helper'

RSpec.describe "Forecast Request" do
  describe "Forecast By City" do
    it "Upper Left Box" do
      get "/api/v1/forecast?location=denver,co"

      expect(response).to be_successful

      forecast_response = JSON.parse(response.body, symbolize_names: true)

      expect(forecast_response[:data][:attributes][:location_info][:city]).to_not eq(nil)
      expect(forecast_response[:data][:attributes][:location_info][:state]).to_not eq(nil)
      expect(forecast_response[:data][:attributes][:location_info][:country]).to_not eq(nil)
      expect(forecast_response[:data][:attributes][:current_time_month_day]).to_not eq(nil)
      expect(forecast_response[:data][:attributes][:weather_description]).to_not eq(nil)
      expect(forecast_response[:data][:attributes][:actual_temp]).to_not eq(nil)
      expect(forecast_response[:data][:attributes][:high_temp]).to_not eq(nil)
      expect(forecast_response[:data][:attributes][:low_temp]).to_not eq(nil)
    end

    it "Upper Left Box" do
      get "/api/v1/forecast?location=denver,co"

      expect(response).to be_successful

      forecast_response = JSON.parse(response.body, symbolize_names: true)

      expect(forecast_response[:data][:attributes][:weather_description]).to_not eq(nil)
      expect(forecast_response[:data][:attributes][:feels_like]).to_not eq(nil)
      expect(forecast_response[:data][:attributes][:humidity]).to_not eq(nil)
      expect(forecast_response[:data][:attributes][:uv_index]).to_not eq(nil)
      expect(forecast_response[:data][:attributes][:sunrise_time]).to_not eq(nil)
      expect(forecast_response[:data][:attributes][:sunset_time]).to_not eq(nil)
    end

    it "Lower Box, Today" do
      get "/api/v1/forecast?location=denver,co"

      expect(response).to be_successful

      forecast_response = JSON.parse(response.body, symbolize_names: true)

      forecast_response[:data][:attributes][:hourly_weather_forecast][0..7].each do |hour_forecast|
        expect(hour_forecast).to have_key(:time)
        expect(hour_forecast).to have_key(:temp)
        expect(hour_forecast).to have_key(:description)

        expect(hour_forecast[:time]).to_not eq(nil)
        expect(hour_forecast[:temp]).to_not eq(nil)
        expect(hour_forecast[:description]).to_not eq(nil)
      end

    end

    it "Lower Box, Week" do
      get "/api/v1/forecast?location=denver,co"

      expect(response).to be_successful

      forecast_response = JSON.parse(response.body, symbolize_names: true)

      forecast_response[:data][:attributes][:week_weather_forecast][0..6].each do |week_forecast|
        expect(week_forecast).to have_key(:day_of_week)
        expect(week_forecast).to have_key(:description)
        expect(week_forecast).to have_key(:precipitation)
        expect(week_forecast).to have_key(:high_temp)
        expect(week_forecast).to have_key(:low_temp)

        expect(week_forecast[:day_of_week]).to_not eq(nil)
        expect(week_forecast[:description]).to_not eq(nil)
        expect(week_forecast[:precipitation]).to_not eq(nil)
        expect(week_forecast[:high_temp]).to_not eq(nil)
        expect(week_forecast[:low_temp]).to_not eq(nil)
      end
    end
  end
  describe "Forecast Background Images by City" do
    it "Background Image Request" do
      get "/api/v1/backgrounds?location=denver,co"

      expect(response).to be_successful

      parsed_background = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_background[:data][:attributes][:image]).to_not eq(nil)
    end
  end
end
