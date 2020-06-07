class GeocodingService
  def get_geocode_objects(city_state)
    geocode_info = get_geocode(city_state)
    Geocode.new(geocode_info)
  end

  private

    def get_geocode(city_state)
      response = Faraday.get("https://maps.googleapis.com/maps/api/geocode/json") do |f|
        f.params[:address] = city_state
        f.params[:key] = ENV['GEOCODING_API_KEY']
      end
      JSON.parse(response.body, symbolize_names: true)
    end
end
