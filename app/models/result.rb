class Result < ActiveRecord::Base
  belongs_to :search
  belongs_to :airline
  belongs_to :airport_from, :class_name =>"Airport"
  belongs_to :airport_to, :class_name =>"Airport"
  attr_accessible :airline_id, :airport_from_id, :airport_to_id, :arrival, :currency, :departure, :price, :search_id, :source_id, :stops, :traveltime
end
