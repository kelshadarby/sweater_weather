class Geocode
  attr_reader :longitude,
              :latitude,
              :city,
              :state,
              :country
              
  def initialize(geocode_info)
    @longitude = geocode_info[:results][0][:geometry][:location][:lng]
    @latitude = geocode_info[:results][0][:geometry][:location][:lat]
    @city = geocode_info[:results][0][:address_components][0][:long_name]
    @state = geocode_info[:results][0][:address_components][2][:long_name]
    @country = geocode_info[:results][0][:address_components][3][:long_name]
  end
end
