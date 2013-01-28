class Search < ActiveRecord::Base
  belongs_to :city_from, :class_name => "City"
  belongs_to :city_to, :class_name => "City"
	belongs_to :search_group
  has_many :results
  attr_accessible :city_from_id, :city_to_id, :active, :return, :departure, :priority, :search_group_id
  validates :return, :departure, :priority, :presence => true

  def execute
    search_in_travelocity_source
  end

	
  def search_in_travelocity_source
    
		result_page = search_with_watir
		# result_page = mock_search_with_watir
	
		summaries_array = analyze_summary(result_page)
		summaries_qty   = save_summaries(id, summaries_array)
	
		# result_array = analyze_result(result_page)
		# results_qty = save_results(id, result_array)
		return summaries_qty
  end
  
  
  def search_with_watir
    from = City.find(self.city_from)
    to   = City.find(self.city_to)
    url = "http://www.travelocity.com.ar/ar/vuelos"    
		timeout = 60
    b = Watir::Browser.new :chrome
    b.goto url
    b.text_field(:id => 'air_from').set     from.name
    b.text_field(:id => 'air_to').set       to.name
    b.text_field(:id => 'air_fromdate').set self.departure.strftime("%d/%m/%Y")
    b.text_field(:id => 'air_todate').set   self.return.strftime("%d/%m/%Y")
    b.button(:name => 'submitFO').click    
    Watir::Wait.until(timeout) { b.title.include? 'Search Results' }
		result_page = b.html
		b.close
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
			summary << [airline, 0, currency, value]
		end
		prices = map_page.css('td.tfNavGridOn span.tfNavPrice') ## Stops Prices
		prices.each do |price| 
			airline  = price.children[1].text
			currency, value = price.children[2].text.split(" ")
			summary << [airline, 1, currency, value]
		end
		return summary
  end


  def analyze_result (page)
		# require 'nokogiri'
    map_page = Nokogiri::HTML(page)
      
    rows = map_page.css('table#tfGrid tr')
    details = rows.collect do |row|
			if (row.text.include? "Roundtrip Price") then
				# Discard this row, it is a title
			else
				detail = {}
				[
				[:airline,      'th/div/span/text()'],
				[:departure,    'td[2]/text()'],
				[:airport_from, 'td[2]/div[1]/span/text()'],
				[:arrival,      'td[3]/text()'],
				[:airport_to,   'td[3]/div[1]/span/text()'],		
				[:traveltime,   'td[4]/text()'],
				[:price,        'td[5]/text()'],
				[:stops,        'td[4]/span/text()'],		
				].each do |name, xpath|
					detail[name] =   row.at_xpath(xpath).to_s.strip.gsub("&nbsp;", "").gsub("-/n", "").gsub(/[()]/, "")
				end
				detail
			end
    end 
		details.shift
		return details
  end

  
  def save_summaries (id, details)
    summary_qty = 0
		details.each do |detail|
			airline = Airline.find_by_name(detail[0])
			if !airline then
				# airline = Airline.create!(:name => details[:airline])
				puts "Airline: " + detail[0] + " not found." 
			else				
				Summary.create!(:source_id => 1,
												:search_id => id,
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
  
  def save_results (id, details)
    require 'chronic'
  
    results_qty = 0
		puts details.inspect
		details.each do |detail|
	  # puts "Airline:" + detail[:airline] 
	  airline = Airline.find_by_name(detail[:airline])
	  if !airline then
	    # airline = Airline.create!(:name => details[:airline])
			puts "Airline: " + detail[:airline] + " not found." 
	  end
	  # puts "From:" + detail[:airport_from] 	  
	  airport_from = Airport.find_by_key(detail[:airport_from])
	  if !airport_from then 
	    # airport_from = Airport.create! (:key => detail[:airport_from])
	    puts "Airport: " + detail[:airport_from] + " not found." 
	  end
	  # puts "To:" + detail[:airport_to] 	  
	  airport_to = Airport.find_by_key(detail[:airport_to])	  
	  if !airport_to then 
	    # airport_to = Airport.create! (:key => detail[:airport_to])
	    puts "Airport: " + detail[:airport_to] + " not found." 
	  end
	  # puts detail[:price]
	  curr, price = detail[:price].chomp.split(" ")
	  # puts detail[:departure]
	  search = Search.find(id)
	  departure = Chronic.parse(search.departure.strftime("%d/%m/%Y") + " " + detail[:departure])
	  # departure.change({:hour => detail[:departure], :min => detail[:departure]}) 
	  arrival = Chronic.parse(search.departure.strftime("%d/%m/%Y") + " " + detail[:arrival])
	  if (airline and airport_from and airport_to) then
		  Result.create!(:airline_id => airline.id, 
						:airport_from_id => airport_from.id, 
						:airport_to_id => airport_to.id, 
						:departure => departure, 
						:arrival => arrival, 
						:currency => curr, 
						:price => price, 
						:search_id => id, 
						:source_id => 1, 
						:stops =>  detail[:stops], 
						:traveltime => detail[:traveltime]
						)
		  results_qty += 1
		end
		return results_qty
  end

  # def analyze_page_1 (page)
    # map_page = Nokogiri::HTML(page)
    # rows = map_page.css('table#tfGrid tr')
    # details = rows.collect do |row|
	  # if (row.text.include? "Roundtrip Price") then
		# Discard this row, it is a title
	  # else
		  # detail = {}
		  # [
			# [:airline,     'span.tfAirline'],
			# [:departure,   'td.tfDepart'],
			# [:airport_from,'div.tfDepAp span'],
			# [:arrival,     'td.tfArrive'],
			# [:airport_to,  'div.tfArrAp span'],		
			# [:traveltime,  'td.tfTime'],
			# [:price,       'td.tfPrice'],
			# [:stops,       'span.tfStops'],
		  # ].each do |name, css_path|
			# puts "name:" + name
			# puts "data:" + row.css(css_path)
			# detail[name] =   row.at_css(css_path).text.to_s.strip.gsub("&nbsp;", "").gsub(/[()]/, "")
		  # end
		  # detail
	  # end
    # end 
	# details.shift
	# puts details.inspect
	# return details  
  # end
 
	
end
