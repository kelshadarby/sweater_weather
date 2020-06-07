class ForecastService
  def get_weather_objects(geocode_object)
    weather_info = get_weather_info(geocode_object)
    Forecast.new(weather_info, geocode_object)
  end

  private


  def get_weather_info(geocode_object)
    response = Faraday.get("https://api.openweathermap.org/data/2.5/onecall") do |f|
      f.params[:appid] = ENV['OPEN_WEATHER_API']
      f.params[:lat] = geocode_object.latitude
      f.params[:lon] = geocode_object.longitude
      f.params[:exclude] = "minutely"
      f.params[:units] = "imperial"
    end

    JSON.parse(response.body, symbolize_names: true)
  end
end
