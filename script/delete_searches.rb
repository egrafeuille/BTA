Search.delete_all
Search.create!(:city_from_id => 600,
								:city_to_id => 711,
								:departure => DateTime.parse("2013-02-02 10:30:00"),
								:return => DateTime.parse("2013-02-09 10:30:00"),
								:active => 1,
								:priority => 1,
								:search_group_id => 1
								)