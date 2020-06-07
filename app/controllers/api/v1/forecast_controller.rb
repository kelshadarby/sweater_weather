class Api::V1::ForecastController < ApplicationController
  def show
    response = Faraday.get("https://maps.googleapis.com/maps/api/geocode/json") do |f|
      f.params[:address] = "Denver,+CO"
      f.params[:key] = ENV['GEOCODING_API_KEY']
    end
    parsed = JSON.parse(response.body, symbolize_names: true)

    lat = parsed[:results][0][:geometry][:location][:lat]
    lng = parsed[:results][0][:geometry][:location][:lng]

    response_2 = Faraday.get("https://api.openweathermap.org/data/2.5/onecall") do |f|
      f.params[:appid] = ENV['OPEN_WEATHER_API']
      f.params[:lat] = lat
      f.params[:lon] = lng
      f.params[:exclude] = "minutely"
      f.params[:units] = "imperial"
    end

    parsed_2 = JSON.parse(response_2.body, symbolize_names: true)

    require "pry"; binding.pry

    # Upper Left Box (CUrrent Data)
    city = parsed[:results][0][:address_components][0][:long_name]
    state = parsed[:results][0][:address_components][2][:long_name]
    country = parsed[:results][0][:address_components][3][:long_name]
    time_day_month_now = DateTime.strptime("#{(parsed_2[:current][:dt] + parsed_2[:timezone_offset])}",'%s').strftime("%l:%M %p, %B %d")
    weather_description = parsed_2[:current][:weather][0][:description]
    actual_temp = weather_description = parsed_2[:current][:temp].to_i
    high_temp = parsed_2[:daily][0][:temp][:max].to_i
    low_temp = parsed_2[:daily][0][:temp][:min].to_i


    # Upper Right Box
    weather_description = parsed_2[:current][:weather][0][:description]
    feels_like = parsed_2[:current][:feels_like].to_i
    humidity = "#{parsed_2[:current][:humidity]}%"
    visibility = parsed_2[:current] # FILL IN LATER
    uv_index = parsed_2[:current][:uvi].to_i
    sunrise_time = DateTime.strptime("#{(parsed_2[:current][:sunrise] + parsed_2[:timezone_offset])}",'%s').strftime("%l:%M %p")
    sunset_time = DateTime.strptime("#{(parsed_2[:current][:sunset] + parsed_2[:timezone_offset])}",'%s').strftime("%l:%M %p")

    # Lower Box, Hourly
    hour_one_time = DateTime.strptime("#{(parsed_2[:hourly][0][:dt] + parsed_2[:timezone_offset])}",'%s').strftime("%l %p")
    hour_one_temp = parsed_2[:hourly][0][:temp]
    hour_one_description = parsed_2[:hourly][0][:weather][0][:description]

    hour_two_time = DateTime.strptime("#{(parsed_2[:hourly][1][:dt] + parsed_2[:timezone_offset])}",'%s').strftime("%l %p")
    hour_two_temp = parsed_2[:hourly][1][:temp]
    hour_two_description = parsed_2[:hourly][1][:weather][0][:description]

    hour_three_time = DateTime.strptime("#{(parsed_2[:hourly][2][:dt] + parsed_2[:timezone_offset])}",'%s').strftime("%l %p")
    hour_three_temp = parsed_2[:hourly][2][:temp]
    hour_three_description = parsed_2[:hourly][2][:weather][0][:description]

    hour_four_time = DateTime.strptime("#{(parsed_2[:hourly][3][:dt] + parsed_2[:timezone_offset])}",'%s').strftime("%l %p")
    hour_four_temp = parsed_2[:hourly][3][:temp]
    hour_four_description = parsed_2[:hourly][3][:weather][0][:description]

    hour_five_time = DateTime.strptime("#{(parsed_2[:hourly][4][:dt] + parsed_2[:timezone_offset])}",'%s').strftime("%l %p")
    hour_five_temp = parsed_2[:hourly][4][:temp]
    hour_five_description = parsed_2[:hourly][4][:weather][0][:description]

    hour_six_time = DateTime.strptime("#{(parsed_2[:hourly][5][:dt] + parsed_2[:timezone_offset])}",'%s').strftime("%l %p")
    hour_six_temp = parsed_2[:hourly][5][:temp]
    hour_six_description = parsed_2[:hourly][5][:weather][0][:description]

    hour_seven_time = DateTime.strptime("#{(parsed_2[:hourly][6][:dt] + parsed_2[:timezone_offset])}",'%s').strftime("%l %p")
    hour_seven_temp = parsed_2[:hourly][6][:temp]
    hour_seven_description = parsed_2[:hourly][6][:weather][0][:description]

    hour_eight_time = DateTime.strptime("#{(parsed_2[:hourly][7][:dt] + parsed_2[:timezone_offset])}",'%s').strftime("%l %p")
    hour_eight_temp = parsed_2[:hourly][7][:temp]
    hour_eight_description = parsed_2[:hourly][7][:weather][0][:description]

    # Lower Box, Week
    
  end
end
