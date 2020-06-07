class Forecast
  attr_reader :actual_temp,
              :current_time_month_day,
              :feels_like,
              :high_temp,
              :hourly_weather_forecast,
              :humidity,
              :location_info,
              :low_temp,
              :sunrise_time,
              :sunset_time,
              :timezone_offset,
              :uv_index,
              :visibility,
              :weather_description,
              :week_weather_forecast

  def initialize(forecast_info, geocode_object)
    @timezone_offset = forecast_info[:timezone_offset]

    @actual_temp = weather_description = forecast_info[:current][:temp].to_i
    @current_time_month_day = find_date_time(forecast_info[:current][:dt], "date")
    @feels_like = forecast_info[:current][:feels_like].to_i
    @high_temp = forecast_info[:daily][0][:temp][:max].to_i
    @hourly_weather_forecast = hour_info(forecast_info)
    @humidity = "#{forecast_info[:current][:humidity]}%"
    @location_info = location(geocode_object)
    @low_temp = forecast_info[:daily][0][:temp][:min].to_i
    @sunrise_time = find_date_time(forecast_info[:current][:sunrise], "time")
    @sunset_time = find_date_time(forecast_info[:current][:sunset], "time")
    @uv_index = forecast_info[:current][:uvi].to_i
    @visibility = forecast_info[:current][:visibility]
    @weather_description = forecast_info[:current][:weather][0][:description].titleize
    @week_weather_forecast = week_info(forecast_info)
  end

  private

  def find_date_time(unix_datetime, date_or_time)
    if date_or_time == "time"
      DateTime.strptime("#{unix_datetime + @timezone_offset}",'%s').strftime("%l:%M %p")
    elsif date_or_time == "date"
      DateTime.strptime("#{unix_datetime + @timezone_offset}",'%s').strftime("%l:%M %p, %B %d")
    end
  end

  def hour_info(forecast_info)
    hourly_weather_forecast = {}
    forecast_info[:hourly][0..7].each_with_index do |info, index|
      hour_num = ("hour_" + (index + 1).to_words).to_sym
      hourly_weather_forecast[hour_num] = {
        time: DateTime.strptime("#{(info[:dt] + @timezone_offset)}",'%s').strftime("%l %p"),
        temp: info[:temp].to_i,
        description: info[:weather][0][:description]
      }
    end
    return hourly_weather_forecast
  end

  def week_info(forecast_info)
    week_weather_forecast = {}
    forecast_info[:daily][0..6].each_with_index do |info, index|
      day_num = ("day_" + (index + 1).to_words).to_sym
      week_weather_forecast[day_num] = {
        day_of_week: DateTime.strptime("#{(info[:dt] + @timezone_offset)}", "%s").strftime("%A"),
        description: info[:weather][0][:description],
        precipitation: info[:rain].nil? ? "0 mm" : "#{info[:rain].to_i} mm",
        high_temp: info[:temp][:max],
        low_temp: info[:temp][:min]
      }
    end
    return week_weather_forecast
  end

  def location(geocode_object)
    {city: geocode_object.city,
     state: geocode_object.state,
     country: geocode_object.country}
  end
end
