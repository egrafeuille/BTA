class Airport < ActiveRecord::Base
  attr_accessible :city_id, :key, :km_to_city, :name
  belongs_to :city
end
