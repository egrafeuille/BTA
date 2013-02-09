class GenericSearch < ActiveRecord::Base
  attr_accessible :city_from_id, :city_to_id, :priority, :search_group_id, :when, :is_active
  
  belongs_to :city_from, :class_name => "City"
  belongs_to :city_to, :class_name => "City"
  belongs_to :search_group
  has_many :results
  has_many :summaries

  validates :city_from_id, :city_to_id, :priority, :presence => true

  scope :actives, where(:is_active => true)
  scope :priority, lambda { |pri| where(:priority => pri) }

  
  def self.run_job(priority)
    generic_searches = GenericSearch.actives.priority(priority)
    generic_searches.each do |generic_search|
      generic_search.run
    end
  end

  def run
    search_dates = SearchDate.actives
    search_dates.each do |search_date|
      search = Search.new(self.id, self.city_from_id, self.city_to_id, search_date.departure, search_date.returndate)
      search.execute
    end
  end

  def sum_qty
    Summary.where(:generic_search_id => self.id).where("price > 1").count
  end

  def sum_max
    Summary.where(:generic_search_id => self.id).where("price > 1").maximum(:price)
  end
  
  def sum_min
    Summary.where(:generic_search_id => self.id).where("price > 1").minimum(:price)
  end


end
