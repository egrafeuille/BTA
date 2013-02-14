select generic_search_id, strftime('%m',departure), max(price), min(price), avg(price), count(*)
from summaries, search_dates
where summaries.search_date_id = search_dates.id
group by generic_search_id, strftime('%m',departure) ;

select generic_search_id, search_date_id, departure, returndate, strftime('%d-%m-%Y', summaries.created_at), min(price)
from summaries, search_dates
where summaries.search_date_id = search_dates.id
and generic_search_id = 650
group by search_date_id, strftime('%d-%m-%Y', summaries.created_at)


and search_date_id = 985