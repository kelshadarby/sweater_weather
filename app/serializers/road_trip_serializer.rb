class RoadTripSerializer
  include FastJsonapi::ObjectSerializer
  attributes  :origin,
              :destination,
              :arrival_forecast,
              :travel_time
end
