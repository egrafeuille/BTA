class Search

  def initialize(id, city_from_id, city_to_id, departure, returndate)
      @id           = id
      @city_from_id = city_from_id
      @city_to_id   = city_to_id
      @departure    = departure
      @returndate   = returndate
  end

  # accesor de escritura y lectura
  attr_accessor :id, :city_from_id, :city_to_id, :departure, :returndate

  def execute
      search_in_travelocity_source
  end


  def search_in_travelocity_source
	result_page = search_with_watir
	# result_page = mock_search_with_watir	
	summaries_array = analyze_summary(result_page)
	summaries_qty   = save_summaries(summaries_array)
	return summaries_qty
  end
  
  
  def search_with_watir
    result_page = ""
    begin
      b = Watir::Browser.new :chrome
      url = "http://www.travelocity.com.ar/ar/vuelos"    
      b.goto url
      b.text_field(:id => 'air_from').set     City.find(self.city_from_id).name
      b.text_field(:id => 'air_to').set       City.find(self.city_to_id).name
      b.text_field(:id => 'air_fromdate').set self.departure.strftime("%d/%m/%Y")
      b.text_field(:id => 'air_todate').set   self.returndate.strftime("%d/%m/%Y")
      b.button(:name => 'submitFO').click    
      timeout = 60
      Watir::Wait.until(timeout) { b.title.include? 'Search Results' }
      result_page = b.html
    rescue Exception => exc
      Rails.logger.error("Error executing search: #{@city_from_id}, #{@city_to_id}, #{@departure}, #{@returndate}: #{exc.message}")
    ensure
      b.close
    end
	return result_page
  end

  
  def mock_search_with_watir
	page = open('doc/travelocity.ar.result.html', &:read)
	return page
  end

  
  def analyze_summary (page)
	summary = []
	map_page = Nokogiri::HTML(page)  
	prices = map_page.css('td.tfNavGrid span.tfNavPrice') ## NonStop Prices
	prices.each do |price| 
		airline  = price.children[1].text
		currency, value = price.children[2].text.split(" ")
		value = value.gsub(/\,/,"")
		summary << [airline, 0, currency, value]
	end
	prices = map_page.css('td.tfNavGridOn span.tfNavPrice') ## Stops Prices
	prices.each do |price| 
		airline  = price.children[1].text
		currency, value = price.children[2].text.split(" ")
		value = value.gsub(/\,/,"")
		summary << [airline, 1, currency, value]
	end
	return summary
  end


  def save_summaries (details)
    summary_qty = 0
	details.each do |detail|
	    # Airline
	    airline = Airline.find_by_name(detail[0])
	    search_date = SearchDate.find_by_departure_and_returndate(self.departure, self.returndate)
	    if 	(airline) && (search_date) && (detail[3] != 1)
			Summary.create!(:source_id => 1,
							:generic_search_id => self.id,
							:search_date_id => search_date.id,
							:airline_id => airline.id,
							:stops => detail[1],
							:currency => detail[2],
							:price => detail[3]
							)
			summary_qty += 1
		end
	end
	return summary_qty
  end

	
end
