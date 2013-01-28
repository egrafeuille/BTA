#
#

a = Search.first
base_date = Date.today.next_month.at_beginning_of_month

#Para el primer mes
# Saliendo c/u de los 30 días del proximo mes
30.times do |d_day|
	departure_date = base_date + d_day
	# Volviendo en 1, 2 y 3 semanas
	3.times do |r_day|
		return_date = departure_date + (r_day + 1) * 7
		Search.create!(:city_from_id => a.city_from_id,
								:city_to_id => a.city_to_id,
								:departure => departure_date,
								:return => return_date,
								:active => 1,
								:priority => 1,
								:search_group_id => 1
								)
	end
end

departure_date = base_date

# Para los siguientes 11 meses
11.times do |month|
	departure_date = departure_date.next_month.at_beginning_of_month
	# Saliendo cada 4 días
	7.times do |day|
		departure_date = departure_date +  4
		# Volviendo en 1, 2 y 3 semanas
		3.times do |r_day|
			return_date = departure_date + (r_day + 1) * 7
			Search.create!(:city_from_id => a.city_from_id,
									:city_to_id => a.city_to_id,
									:departure => departure_date,
									:return => return_date,
									:active => 1,
									:priority => 1,
									:search_group_id => 1
									)
		end
	end
end
