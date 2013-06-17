class Result < ActiveRecord::Base
  attr_accessible :route_id, :source_id, :airport_from_id, :airport_to_id, :departure, :returndate, :airline_id, 
            :stops, :currency, :price, :traveltime, :ticket_class, :is_roundtrip, :result_type, :result_date

  CURRENCIES = [ "USS", "EUR", "ARS" ]
  TICKET_CLASSES = [ " ", "Economic", "Business", "First Class"]
  RESULT_TYPES = [ "Res", "Ref", "Min", "Max"]
  
  belongs_to :airline
  belongs_to :airport_from, :class_name =>"Airport"
  belongs_to :airport_to, :class_name =>"Airport"
  belongs_to :source
  belongs_to :route
  
  validates :route_id, :source_id, :airport_from_id, :airport_to_id, :departure,  
            :stops, :currency, :price, :result_type, :result_date, :presence => true
  validates_presence_of :returndate, :unless => :is_roundtrip?            
  validates :stops, :inclusion => { :in => 0..10, :message => "Stops must be between 0 and 10" }
  validates :currency, :inclusion => {:in => Result::CURRENCIES, :message => "%{value} is not a valid currency" }
  validates :price, :numericality => { :greater_than => 0 }
#  validates :ticket_class, :inclusion => { :in => Result::TICKET_CLASSES, :message => "%{value} is not a valid ticket class" }
  validates :result_type, :inclusion => {:in => Result::RESULT_TYPES, :message => "%{value} is not a valid result type" }
  validate :check_airport_from_and_airport_to
  
  def check_airport_from_and_airport_to
    errors.add(:airport_to_id, "can't be the same as airport from") if airport_from_id == airport_to_id
  end
  
  scope :result_type, lambda { |type| where(:result_type=> type) }
  scope :nonstops, where(:stops => 0)
  
end
