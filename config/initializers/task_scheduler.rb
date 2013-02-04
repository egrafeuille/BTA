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

SearchDate.new_date
scheduler.every "1d",  :first_at => 'tomorrow at 0:01am', :tags => 'New Date' do
    SearchDate.new_date
end
