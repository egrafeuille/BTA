
require 'rubygems'
require 'mechanize'
require 'logger'

url1 = "http://www.travelocity.com.ar/ar/"
# POST
url2 = "http://go.travelpn.com/flights/InitialSearch.do" 
# Javascript window.location.replace(finurl);
url3 = "http://go.travelpn.com/flights/ResolveAirportAction.do?SEQ=13581911136160142013&affiliateId=10019887"
url4 = "http://go.travelpn.com/flights/AirSearch.do?SEQ=13581910485750142013&affiliateId=10019887"

form1 = "formair"
form2 = "AirSearchForm"


a = Mechanize.new { |ag|
  ag.follow_meta_refresh = true
#  ag.log = Logger.new $stderr
#  ag.agent.http.debug_output = $stderr
  
}

a.get(url1) do |search_page|

  puts "PASO 1: " + search_page.title
  searching_page = search_page.form_with(:name => form1) do |form|

#  puts "search page:"
#  puts search_page.title
#  puts "form:"
#  puts search_page.forms
#  puts "fields:"
#  puts search_page.forms[0].fields
#  puts search_page.forms[1].fields
  
	form.leavingFrom = "Buenos Aires"
	form.goingTo = "Rio"
	form.leavingDateLA = "02/02/2013"
	form.returningDateLA = "09/02/2013"


#	form.leavingDate = "02/02/2013"
#	form.returningDate = "09/02/2013"
#	form.leavingFrom = "Buenos Aires"
#	form.goingTo = "Rio"

 
  end.submit

  puts "PASO 2: " + searching_page.title
  puts "URL: " + searching_page.uri.to_s
#  puts "searching page body:"
#  puts searching_page.body

end

puts "Sleeping..."
sleep 60

a.get(url3) 
puts "PASO 3: " + a.page.title
puts "URL: " + a.page.uri.to_s

a.get(url4) 
puts "PASO 4: " + a.page.title
puts "URL: " + a.page.uri.to_s

#puts "history:"
#puts a.history.inspect

