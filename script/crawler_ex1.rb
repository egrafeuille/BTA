
require 'rubygems'
require 'mechanize'
require 'logger'

a = Mechanize.new { |ag|
  ag.follow_meta_refresh = true
#  ag.log = Logger.new $stderr
#  ag.agent.http.debug_output = $stderr
  
}

url1 = "http://www.travelocity.com.ar/ar/" 
url2 = "http://go.travelpn.com/flights/AirSearch.do?SEQ=13580079319480122013&affiliateId=10019887#modSearch"
url3 = "http://go.travelpn.com/flights/AirSearch.do?SEQ=13581836816250142013&affiliateId=10019887"

form1 = "formair"
form2 = "AirSearchForm"

a.get(url2) do |search_page|

  result_page = search_page.form_with(:name => form2) do |form|

#  puts "search page:"
#  puts search_page.title
#  puts "form:"
#  puts search_page.forms
#  puts "fields:"
#  puts search_page.forms[0].fields
#  puts search_page.forms[1].fields
  
#	form.leavingFrom = "Buenos Aires"
#	form.goingTo = "Rio"
#	form.leavingDateLA = "02/02/2013"
#	form.returningDateLA = "09/02/2013"


	form.leavingDate = "02/02/2013"
	form.returningDate = "09/02/2013"
	form.leavingFrom = "Buenos Aires"
	form.goingTo = "Rio"

 
  end.submit

  puts "Sleeping..."
  sleep 60
  
  puts "searching page title:"
  puts result_page.title
#  puts "result page body:"
#  puts result_page.body

end

a.get(url3) 
puts "result page title:"
puts a.page.title


puts "history:"
puts a.history.inspect

