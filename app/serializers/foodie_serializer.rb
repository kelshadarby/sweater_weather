class FoodieSerializer
  include FastJsonapi::ObjectSerializer
  attributes  :end_location,
              :restaurant,
              :forecast,
              :travel_time
end
