require 'watir-webdriver'
require 'nokogiri'

# url = "http://www.travelocity.com.ar/ar/vuelos"


# b = Watir::Browser.new :chrome
# b.goto url
# b.text_field(:id => 'air_from').set "Buenos Aires"
# b.text_field(:id => 'air_to').set "Rio"
# b.text_field(:id => 'air_fromdate').set "02/02/2013"
# b.text_field(:id => 'air_todate').set "09/02/2013"
# b.button(:name => 'submitFO').click

# Watir::Wait.until { b.title.include? 'Search Results' }

# page = Nokogiri::HTML(b.html)

f = File.open('doc/travelocity.ar.result.html')
page = Nokogiri::HTML(f)
f.close

puts "Analizando Resultados"



#page.css('table#tfGrid tr').each do |row|
#
#  airline     = row.search( '@class="tfAirline"'  ).text.strip rescue ''
#  departure   = row.search( '@class="tfDepart"'   ).text.strip rescue ''
#  arrival     = row.search( '@class="tfArrive"'   ).text.strip rescue ''
#  traveltime  = row.search( '@class="tfTime"'     ).text.strip rescue ''
#  price       = row.search( '@class="tfPrice"'    ).text.strip rescue ''
#  
#end

rows = page.css('table#tfGrid tr')
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

puts details.inspect

puts "End"
