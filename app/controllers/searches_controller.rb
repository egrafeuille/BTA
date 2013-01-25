class SearchesController < ApplicationController
  # GET /searches
  # GET /searches.json
  def index
    @searches = Search.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @searches }
    end
  end

  # GET /searches/1
  # GET /searches/1.json
  def show
    @search = Search.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @search }
    end
  end

  # GET /searches/new
  # GET /searches/new.json
  def new
    @search = Search.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @search }
    end
  end

  # GET /searches/1/edit
  def edit
    @search = Search.find(params[:id])
  end



  # POST /searches
  # POST /searches.json
  def create
    @search = Search.new(params[:search])

    respond_to do |format|
      if @search.save
        format.html { redirect_to @search, notice: 'Search was successfully created.' }
        format.json { render json: @search, status: :created, location: @search }
      else
        format.html { render action: "new" }
        format.json { render json: @search.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /searches/1
  # PUT /searches/1.json
  def update
    @search = Search.find(params[:id])

    respond_to do |format|
      if @search.update_attributes(params[:search])
        format.html { redirect_to @search, notice: 'Search was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @search.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /searches/1
  # DELETE /searches/1.json
  def destroy
    @search = Search.find(params[:id])
    @search.destroy

    respond_to do |format|
      format.html { redirect_to searches_url }
      format.json { head :no_content }
    end
  end
  
  # GET /searches/1/execute
  def execute
		qty = search_in_travelocity_source(params[:id])
    
		respond_to do |format|
			if qty
				format.html { redirect_to searches_url, notice: 'Search was successfully executed.' }
				format.json { head :no_content }
			else
				format.html { render action: "show" }
				format.json { render json: @search.errors, status: :unprocessable_entity }
			end
		end
  end

  def search_in_travelocity_source (id)
    
		# result_page = search_with_watir(id)
		result_page = mock_search_with_watir
	
		summaries_array = analyze_summary(result_page)
		summaries_qty   = save_summaries(id, summaries_array)
	
		# result_array = analyze_result(result_page)
		# results_qty = save_results(id, result_array)
		return summaries_qty
  end
  
  
  def search_with_watir (id)
    # require 'watir-webdriver'

    search = Search.find(id)
    from = City.find(search.city_from)
    to   = City.find(search.city_to)
    url = "http://www.travelocity.com.ar/ar/vuelos"
    
    b = Watir::Browser.new :chrome
    b.goto url
    b.text_field(:id => 'air_from').set     from.name
    b.text_field(:id => 'air_to').set       to.name
    b.text_field(:id => 'air_fromdate').set search.departure.strftime("%d/%m/%Y")
    b.text_field(:id => 'air_todate').set   search.return.strftime("%d/%m/%Y")
    b.button(:name => 'submitFO').click    
    Watir::Wait.until { b.title.include? 'Search Results' }
		return b.html
  end

  
  def mock_search_with_watir
		page = open('doc/travelocity.ar.result.html', &:read)
		return page
  end

  
  def analyze_summary (page)
		# require 'nokogiri'
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
		# puts summary.inspect
		# puts summary[0][0]
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
