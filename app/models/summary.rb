class Summary < ActiveRecord::Base
  belongs_to :search
  belongs_to :search_date
  belongs_to :airline
	belongs_to :sources
  attr_accessible :airline_id, :currency, :price, :search_id, :search_date_id, :source_id, :stops, :created_at
end
