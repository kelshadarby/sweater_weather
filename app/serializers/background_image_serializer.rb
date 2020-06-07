class BackgroundImageSerializer
  include FastJsonapi::ObjectSerializer
  attributes  :image

  set_id { |i| i = 1 }
end
