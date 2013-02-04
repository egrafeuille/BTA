class SearchDate < ActiveRecord::Base
  attr_accessible :departure, :is_active, :returndate

  has_many :summaries

# validates :departure, :returndate, :presence => true
  validates :departure, :presence => true, :uniqueness => {:scope => :returndate}
  validates :returndate, :presence => true

  scope :actives, where(:is_active => true)
  scope :in_next_n_days, (lambda do |days|
    limit_date = Date.today + days
    where('departure < ?' , limit_date)
  end)


  def self.new_date
    # Desactivar las busquedas de la próxima semana
    search_dates_to_deactive = SearchDate.actives.in_next_n_days(7)
    search_dates_to_deactive.each do |search_date|
      search_date.is_active = false
      search_date.save
    end
    # Activar las búsquedas diarias de los 30 días siguientes
    base_date = Date.today + 7.days
    30.times do |d|
  	   departure_date = base_date + d.days
  	   # Volviendo en 1, 2 y 3 semanas
  	   3.times do |r|
  		  return_date = departure_date + ((r + 1) * 7).days
  		  search_date = SearchDate.find_or_initialize_by_departure_and_returndate(departure_date, return_date)
  		  search_date.is_active = true
  		  search_date.save
  	   end
    end
    # Activar las busquedas (cada 4 días) para los siguientes 10 meses x 7 veces al mes (aprox) 
    base_date = Date.today + 30.days + 7.days
    (10 * 7).times do |d|
	   departure_date = base_date + (d * 4).days
  	   # Volviendo en 1, 2 y 3 semanas
  	   3.times do |r|
  			return_date = departure_date + (r + 1) * 7
  			search_date = SearchDate.find_or_initialize_by_departure_and_returndate(departure_date, return_date)
  		    search_date.is_active = true
  		    search_date.save
  	   end
  	end
  end
  
end
