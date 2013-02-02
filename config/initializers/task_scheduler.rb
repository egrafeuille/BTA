scheduler = Rufus::Scheduler.start_new

scheduler.every "10m", :tags => 'Priority 1' do
    GenericSearch.run_job(1)
end

scheduler.every "3d", :tags => 'Priority 2' do
    GenericSearch.run_job(2)
end

scheduler.every "7d", :tags => 'Priority 3' do
    GenericSearch.run_job(3)
end

#scheduler.every "1d",  :first_at => 'tomorrow at 1am', :tags => 'New Date' do
#    SearchDate.newDate
#end
