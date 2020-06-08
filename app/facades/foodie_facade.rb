class FoodieFacade
  attr_reader :id,
              :end_location

  def initialize(start_location, end_location, restaurant_info)
    @id = "null"
    @restaurant_info = restaurant_info
    @start_location = start_location
    @end_location = end_location
  end

  def restaurant
    {
      name: @restaurant_info[:restaurants][0][:restaurant][:name],
      address: @restaurant_info[:restaurants][0][:restaurant][:location][:address]
    }
  end

  def forecast
    serialized_forecast = get_serialized_forecast
    {
      summary: serialized_forecast[:data][:attributes][:weather_description],
      temperature: serialized_forecast[:data][:attributes][:actual_temp]
    }
  end

  def travel_time
    trip_object.duration
  end

  private

  def get_serialized_forecast
    json = ForecastSerializer.new(get_forecast_object).serialized_json
    JSON.parse(json, symbolize_names: true)
  end

  def get_forecast_object
    forecast_service = ForecastService.new(@end_location)
    forecast_service.get_forecast_objects
  end

  def trip_object
    (GeocodingService.new).get_trip_object(@start_location, @end_location)
  end
end
