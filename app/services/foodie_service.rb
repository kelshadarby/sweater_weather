class FoodieService

  def initialize(start_location, end_location, cuisine)
    @start_location = start_location
    @end_location = end_location
    @cuisine = cuisine
  end

  def get_restaurant_object
    restaurant_info = get_restaurants
    FoodieFacade.new(@start_location, @end_location, restaurant_info)
  end

  private

  def get_restaurants
    zomato_response = Faraday.get("https://developers.zomato.com/api/v2.1/search") do |f|
      f.headers[:user_key] = ENV["ZOMATO_API_KEY"]
      f.params[:lat] = get_latitude
      f.params[:lon] = get_longitude
      f.params[:q] = @cuisine
    end
    JSON.parse(zomato_response.body, symbolize_names: true)
  end

  def get_longitude
    geocode = (GeocodingService.new).get_geocode_objects(@end_location)
    geocode.longitude
  end

  def get_latitude
    geocode = (GeocodingService.new).get_geocode_objects(@end_location)
    geocode.latitude
  end
end
