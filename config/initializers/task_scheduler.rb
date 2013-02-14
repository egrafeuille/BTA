scheduler = Rufus::Scheduler.start_new

#scheduler.every "1d", :first_in => '2m', :tags => 'Priority 1' do
#    GenericSearch.run_job(1)
#end

scheduler.every "3d", :first_in => '2h', :tags => 'Priority 2' do
    GenericSearch.run_job(2)
end

scheduler.every "7d", :first_in => '6h', :tags => 'Priority 3' do
    GenericSearch.run_job(3)
end

#scheduler.every "1d",  :first_at => 'tomorrow at 0:01am', :tags => 'New Date' do
#    SearchDate.new_date
#end
