class TripService
  def get_restaurant_object(location, cuisine)
    restaurant_info = get_restaurants(location, cuisine)
    FoodieFacade.new(restaurant_info)
  end

  private

  def get_restaurants(location, cuisine)
    zomato_response = Faraday.get("https://developers.zomato.com/api/v2.1/search") do |f|
      f.headers[:user_key] = ENV["ZOMATO_API_KEY"]
      f.params[:lat] = get_latitude(location)
      f.params[:lon] = get_longitude(location)
      f.params[:q] = params[:search]
    end
    JSON.parse(zomato_response.body, symbolize_names: true)
  end

  def get_longitude(location)
    geocode = (GeocodingService.new).get_geocode_objects(params[:end])
    geocode.longitude
  end

  def get_latitude(location)
    geocode = (GeocodingService.new).get_geocode_objects(params[:end])
    geocode.latitude
  end

  def get_trip_info

  end
end
