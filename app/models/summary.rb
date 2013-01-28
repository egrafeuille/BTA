class Summary < ActiveRecord::Base
  attr_accessible :airline_id, :currency, :price, :search_id, :source_id, :stops, :created_at
end
