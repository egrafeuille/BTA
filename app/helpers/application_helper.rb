module ApplicationHelper

def nice_date_form(the_date)
   return the_date.strftime('%d/%m/%Y')
end

def nice_datetime_form(the_date)
   return the_date.strftime('%d/%m/%Y %H:%M:%S')
end

end
