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

  # GET /searches/1/execute
  def execute
    search_in_travelocity_source(params[:id])
    
#    search_in_travelocity_source(:search)

#    respond_to do |format|
#      if @search.search_in_travelocity_source(params[:search])
#        format.html { redirect_to @search, notice: 'Search was successfully executed.' }
#        format.json { head :no_content }
#      else
#        format.html { render action: "show" }
#        format.json { render json: @search.errors, status: :unprocessable_entity }
#      end
#    end
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
  
  def search_with_watir (id)
    require 'watir-webdriver'

    search = Search.find(id)
    from = City.find(search.city_from)
    to   = City.find(search.city_to)
    url = "http://www.travelocity.com.ar/ar/vuelos"
    
    b = Watir::Browser.new :chrome
    b.goto url
    b.text_field(:id => 'air_from').set     from.name
    b.text_field(:id => 'air_to').set       to.name
    b.text_field(:id => 'air_fromdate').set search.departure.strftime("%d/%m/%Y")
    b.text_field(:id => 'air_todate').set   search.arrival.strftime("%d/%m/%Y")
    b.button(:name => 'submitFO').click    
    Watir::Wait.until { b.title.include? 'Search Results' }
	return b.html
  end

  def mock_search_with_watir
    f = File.open('doc/travelocity.ar.result.html')
    page = Nokogiri::HTML(f)
    f.close
	return page
  end
  
  def analyze_page (page)
	require 'nokogiri'
    map_page = Nokogiri::HTML(page)
      
    rows = map_page.css('table#tfGrid tr')
    details = rows.collect do |row|
      detail = {}
      [
        [:airline,    'th/div/span/text()'],
        [:departure,  'td[2]/text()'],
		[:airport_from,  'td[2]/div[1]/span/text()'],
        [:arrival,    'td[3]/text()'],
		[:airport_to,  'td[3]/div[1]/span/text()'],		
        [:traveltime, 'td[4]/text()'],
        [:price,      'td[5]/text()'],
      ].each do |name, xpath|
        detail[name] =   row.at_xpath(xpath).to_s.strip.gsub("&nbsp;", "").gsub(/[()]/, "")
      end
      detail
    end 
	details.shift
	return details
  end
  
  def save_results (details)
  
	details.each do |detail|
	  # puts "Airline:" + detail[:airline] 
	  airline = Airline.find_by_name(detail[:airline])
	  if !airline then
	    airline = Airline.create!(:name => details[:airline])
		puts "Airline: " + airline.name + " created." 
	  end
	  # puts "From:" + detail[:airport_from] 	  
	  airport_from = Airport.find_by_key(detail[:airport_from])
	  if !airport_from then 
	    airport_from = Airport.create! (:key => detail[:airport_from])
	    puts "Airport: " + airport_from.key + " created." 
	  end
	  # puts "To:" + detail[:airport_to] 	  
	  airport_to = Airport.find_by_key(detail[:airport_to])	  
	  if !airport_to then 
	    airport_to = Airport.create! (:key => detail[:airport_to])
	    puts "Airport: " + airport_to.key + " created." 
	  end
	  # puts detail[:price]
	  curr, price = detail[:price].chomp.split(" ")
	  Result.create!(:airline_id => airline.id, 
					:airport_from_id => airport_from.id, 
					:airport_to_id => airport_to.id, 
					:departure => detail[:departure], 
					:arrival => detail[:arrival], 
					:currency => curr, 
					:price => price, 
					:search_id => search.id, 
					:source_id => 1, 
					:stops =>  1, 
					:traveltime => detail[:traveltime]
					)
	end
  end
  
  def search_in_travelocity_source (id)
    
	# result_page = search_with_watir (id)
	result_page = mock_search_with_watir
	
	result_array = analyze_page (result_page)
	
	save_results (result_array)
	
  end
  
  
end
