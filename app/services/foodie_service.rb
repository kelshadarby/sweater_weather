class FoodieService
  def get_restaurant_object(start_location, end_location, cuisine)
    restaurant_info = get_restaurants(end_location, cuisine)
    FoodieFacade.new(start_location, end_location, restaurant_info)
  end

  private

  def get_restaurants(end_location, cuisine)
    zomato_response = Faraday.get("https://developers.zomato.com/api/v2.1/search") do |f|
      f.headers[:user_key] = ENV["ZOMATO_API_KEY"]
      f.params[:lat] = get_latitude(end_location)
      f.params[:lon] = get_longitude(end_location)
      f.params[:q] = cuisine
    end
    JSON.parse(zomato_response.body, symbolize_names: true)
  end

  def get_longitude(end_location)
    geocode = (GeocodingService.new).get_geocode_objects(end_location)
    geocode.longitude
  end

  def get_latitude(end_location)
    geocode = (GeocodingService.new).get_geocode_objects(end_location)
    geocode.latitude
  end
end
