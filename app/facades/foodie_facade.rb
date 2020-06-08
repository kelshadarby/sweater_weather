class FoodieFacade
  attr_reader :restaurant_info

  def initialize(location, restaurant_info)
    @restaurant_info = restaurant_info
    @start_location = start_location
    @end_location = end_location
  end

  def end_location
    @end_location
  end

  def name
    @restaurant_info[:restaurants][0][:restaurant][:name]
  end

  def address
    @restaurant_info[:restaurants][0][:restaurant][:location][:address]
  end

  def forecast
    serialized_forecast = get_serialized_forecast
    {
      summary: serialized_forecast[:data][:attributes][:weather_description],
      temperature: serialized_forecast[:data][:attributes][:actual_temp]
    }
  end

  private

  def get_serialized_forecast
    json = ForecastSerializer.new(get_forecast_object).serialized_json
    JSON.parse(json, symbolize_names: true)
  end

  def get_forecast_object
    forecast_service = ForecastService.new(params[:end])
    forecast_service.get_forecast_objects
  end

  def trip_object
    get_trip_object(start_location, end_location)
  end
end
