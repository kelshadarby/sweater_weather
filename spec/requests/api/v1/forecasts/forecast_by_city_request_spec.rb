require 'rails_helper'

RSpec.describe "Forecast Request" do
  describe "Forecast By City" do
    it "Upper Left Box" do
      get "/api/v1/forecast?location=denver,co"

      expect(response).to be_successful

      parsed_forecast = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_forecast[:now][:city_state]).to_not eq(nil)
      expect(parsed_forecast[:now][:country]).to_not eq(nil)
      expect(parsed_forecast[:now][:time]).to_not eq(nil)
      expect(parsed_forecast[:now][:month_day]).to_not eq(nil)
      expect(parsed_forecast[:now][:weather_description]).to_not eq(nil)
      expect(parsed_forecast[:now][:weather_actual_temp]).to_not eq(nil)
      expect(parsed_forecast[:now][:weather_high_temp]).to_not eq(nil)
      expect(parsed_forecast[:now][:weather_low_temp]).to_not eq(nil)
    end

    it "Upper Left Box" do
      get "/api/v1/forecast?location=denver,co"

      expect(response).to be_successful

      parsed_forecast = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_forecast[:now][:weather_description]).to_not eq(nil)
      expect(parsed_forecast[:now][:feels_like]).to_not eq(nil)
      expect(parsed_forecast[:now][:humidity]).to_not eq(nil)
      expect(parsed_forecast[:now][:visibility]).to_not eq(nil)
      expect(parsed_forecast[:now][:uv_index]).to_not eq(nil)
      expect(parsed_forecast[:now][:sunrise_time]).to_not eq(nil)
      expect(parsed_forecast[:now][:sunset_time]).to_not eq(nil)
    end

    it "Lower Box, Today" do
      get "/api/v1/forecast?location=denver,co"

      expect(response).to be_successful

      parsed_forecast = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_forecast[:today][:hour_one][:hour_time]).to_not eq(nil)
      expect(parsed_forecast[:today][:hour_one][:temp]).to_not eq(nil)
      expect(parsed_forecast[:today][:hour_one][:description]).to_not eq(nil)

      expect(parsed_forecast[:today][:hour_two][:hour_time]).to_not eq(nil)
      expect(parsed_forecast[:today][:hour_two][:temp]).to_not eq(nil)
      expect(parsed_forecast[:today][:hour_two][:description]).to_not eq(nil)

      expect(parsed_forecast[:today][:hour_three][:hour_time]).to_not eq(nil)
      expect(parsed_forecast[:today][:hour_three][:temp]).to_not eq(nil)
      expect(parsed_forecast[:today][:hour_three][:description]).to_not eq(nil)

      expect(parsed_forecast[:today][:hour_four][:hour_time]).to_not eq(nil)
      expect(parsed_forecast[:today][:hour_four][:temp]).to_not eq(nil)
      expect(parsed_forecast[:today][:hour_four][:description]).to_not eq(nil)

      expect(parsed_forecast[:today][:hour_five][:hour_time]).to_not eq(nil)
      expect(parsed_forecast[:today][:hour_five][:temp]).to_not eq(nil)
      expect(parsed_forecast[:today][:hour_five][:description]).to_not eq(nil)

      expect(parsed_forecast[:today][:hour_six][:hour_time]).to_not eq(nil)
      expect(parsed_forecast[:today][:hour_six][:temp]).to_not eq(nil)
      expect(parsed_forecast[:today][:hour_six][:description]).to_not eq(nil)

      expect(parsed_forecast[:today][:hour_seven][:hour_time]).to_not eq(nil)
      expect(parsed_forecast[:today][:hour_seven][:temp]).to_not eq(nil)
      expect(parsed_forecast[:today][:hour_seven][:description]).to_not eq(nil)

      expect(parsed_forecast[:today][:hour_eight][:hour_time]).to_not eq(nil)
      expect(parsed_forecast[:today][:hour_eight][:temp]).to_not eq(nil)
      expect(parsed_forecast[:today][:hour_eight][:description]).to_not eq(nil)
    end

    it "Lower Box, Week" do
      get "/api/v1/forecast?location=denver,co"

      expect(response).to be_successful

      parsed_forecast = JSON.parse(response.body, symbolize_names: true)

      weekly_forecast_keys = [:day_one, :day_two, :day_three, :day_four, :day_five, :day_six]

      weekly_forecast_keys.each do |key|
        expect(parsed_forecast[:week][key][:day_of_week])
        expect(parsed_forecast[:week][key][:description])
        expect(parsed_forecast[:week][key][:percipitation])
        expect(parsed_forecast[:week][key][:high_temp])
        expect(parsed_forecast[:week][key][:low_temp])
      end

      expect(parsed_forecast[:week][:day_one][:day_of_week])
      expect(parsed_forecast[:week][:day_one][:description])
      expect(parsed_forecast[:week][:day_one][:percipitation])
      expect(parsed_forecast[:week][:day_one][:high_temp])
      expect(parsed_forecast[:week][:day_one][:low_temp])

      expect(parsed_forecast[:week][:day_two][:day_of_week])
      expect(parsed_forecast[:week][:day_two][:description])
      expect(parsed_forecast[:week][:day_two][:percipitation])
      expect(parsed_forecast[:week][:day_two][:high_temp])
      expect(parsed_forecast[:week][:day_two][:low_temp])

      expect(parsed_forecast[:week][:day_three][:day_of_week])
      expect(parsed_forecast[:week][:day_three][:description])
      expect(parsed_forecast[:week][:day_three][:percipitation])
      expect(parsed_forecast[:week][:day_three][:high_temp])
      expect(parsed_forecast[:week][:day_three][:low_temp])

      expect(parsed_forecast[:week][:day_four][:day_of_week])
      expect(parsed_forecast[:week][:day_four][:description])
      expect(parsed_forecast[:week][:day_four][:percipitation])
      expect(parsed_forecast[:week][:day_four][:high_temp])
      expect(parsed_forecast[:week][:day_four][:low_temp])

      expect(parsed_forecast[:week][:day_five][:day_of_week])
      expect(parsed_forecast[:week][:day_five][:description])
      expect(parsed_forecast[:week][:day_five][:percipitation])
      expect(parsed_forecast[:week][:day_five][:high_temp])
      expect(parsed_forecast[:week][:day_five][:low_temp])

      expect(parsed_forecast[:week][:day_six][:day_of_week])
      expect(parsed_forecast[:week][:day_six][:description])
      expect(parsed_forecast[:week][:day_six][:percipitation])
      expect(parsed_forecast[:week][:day_six][:high_temp])
      expect(parsed_forecast[:week][:day_six][:low_temp])

      expect(parsed_forecast[:week][:day_seven][:day_of_week])
      expect(parsed_forecast[:week][:day_seven][:description])
      expect(parsed_forecast[:week][:day_seven][:percipitation])
      expect(parsed_forecast[:week][:day_seven][:high_temp])
      expect(parsed_forecast[:week][:day_seven][:low_temp])
    end
  end
end
