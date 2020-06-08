class Trip
  def initialize(trip_info)
    @duration = trip_info[:routes][0][:legs][0][:duration][:text]
  end
end
