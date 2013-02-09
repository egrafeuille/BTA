class Summary < ActiveRecord::Base
  belongs_to :generic_search
  belongs_to :search_date
  belongs_to :airline
  belongs_to :source
  attr_accessible :airline_id, :currency, :price, :generic_search_id, :search_date_id, :source_id, :stops, :created_at
end
