class Geocode
  attr_reader :city,
              :country,
              :latitude,
              :longitude,
              :state

  def initialize(geocode_info)
    @city = geocode_info[:results][0][:address_components][0][:long_name]
    @country = geocode_info[:results][0][:address_components][3][:long_name]
    @latitude = geocode_info[:results][0][:geometry][:location][:lat]
    @longitude = geocode_info[:results][0][:geometry][:location][:lng]
    @state = geocode_info[:results][0][:address_components][2][:long_name]
  end
end
