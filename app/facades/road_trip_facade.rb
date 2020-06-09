class RoadTripFacade
  attr_reader :id,
              :origin,
              :destination

  def initialize(start_location, end_location)
    @id = "null"
    @origin = start_location
    @destination = end_location
  end

  def arrival_forecast
    get_serialized_forecast[:data][:attributes][:hourly_weather_forecast].each do |hour|
      if hour[:time] == get_arrival_time
        return "#{hour[:temp]}, #{hour[:description]}"
      end
    end
  end

  def travel_time
    trip_duration[:text]
  end

  private

    def get_serialized_forecast
      json = ForecastSerializer.new(get_forecast_object).serialized_json
      JSON.parse(json, symbolize_names: true)
    end

    def get_forecast_object
      forecast_service = ForecastService.new(@destination)
      forecast_service.get_forecast_objects
    end

    def trip_duration
      (GeocodingService.new).get_trip_duration(@origin, @destination)
    end

    def get_arrival_time
      arrival_time = (Time.now.utc.to_i + get_forecast_object.timezone_offset) + trip_duration[:value]
      DateTime.strptime("#{arrival_time}",'%s').strftime("%l %p")
    end
end
