class ForecastService
  attr_reader :location

  def initialize(location)
    @location = location
  end

  def get_forecast_objects
    forecast_info = get_forecast_info
    ForecastFacade.new(forecast_info, geocode_object)
  end

  private

  def get_forecast_info
    response = Faraday.get("https://api.openweathermap.org/data/2.5/onecall") do |f|
      f.params[:appid] = ENV['OPEN_WEATHER_API']
      f.params[:lat] = geocode_object.latitude
      f.params[:lon] = geocode_object.longitude
      f.params[:exclude] = "minutely"
      f.params[:units] = "imperial"
    end

    JSON.parse(response.body, symbolize_names: true)
  end

  def geocode_object
    (GeocodingService.new).get_geocode_objects(@location)
  end
end
