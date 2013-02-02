class GenericSearchesController < ApplicationController
  # GET /generic_searches
  # GET /generic_searches.json
  def index
    # @generic_searches = GenericSearch.all
	@generic_searches = GenericSearch.paginate :page=>params[:page], :order=>'created_at desc',
			:per_page => 50

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @generic_searches }
    end
  end

  # GET /generic_searches/1
  # GET /generic_searches/1.json
  def show
    @generic_search = GenericSearch.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @generic_search }
    end
  end

  # GET /generic_searches/new
  # GET /generic_searches/new.json
  def new
    @generic_search = GenericSearch.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @generic_search }
    end
  end

  # GET /searches/1/edit
  def edit
    @generic_search = GenericSearch.find(params[:id])
  end



  # POST /generic_searches
  # POST /generic_searches.json
  def create
    @generic_search = GenericSearch.new(params[:generic_search])

    respond_to do |format|
      if @generic_search.save
        format.html { redirect_to @generic_search, notice: 'Generic Search was successfully created.' }
        format.json { render json: @generic_search, status: :created, location: @generic_search }
      else
        format.html { render action: "new" }
        format.json { render json: @generic_search.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /generic_searches/1
  # PUT /generic_searches/1.json
  def update
    @generic_search = GenericSearch.find(params[:id])

    respond_to do |format|
      if @generic_search.update_attributes(params[:generic_search])
        format.html { redirect_to @generic_search, notice: 'Generic Search was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @generic_search.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /generic_searches/1
  # DELETE /generic_searches/1.json
  def destroy
    @generic_search = GenericSearch.find(params[:id])
    @generic_search.destroy

    respond_to do |format|
      format.html { redirect_to generic_searches_url }
      format.json { head :no_content }
    end
  end
  
    # GET /searches/1/execute
  def execute
    @generic_search = GenericSearch.find(params[:id])
    @generic_search.run 
            
	respond_to do |format|
	 if (true)   ## TODO
		format.html { redirect_to generic_searches_url, notice: 'Generic Search was successfully executed.' }
		format.json { head :no_content }
	 else
		format.html { render action: "show" }
		format.json { render json: @generic_search.errors, status: :unprocessable_entity }
	 end
	end
	
  end
    
end
