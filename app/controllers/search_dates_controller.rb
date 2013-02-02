class SearchDatesController < ApplicationController
  # GET /search_dates
  # GET /search_dates.json
  def index
    # @search_dates = SearchDate.all
		@search_dates = SearchDate.paginate :page=>params[:page], :order=>'departure asc',
			:per_page => 50
		

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @search_dates }
    end
  end

  # GET /search_dates/1
  # GET /search_dates/1.json
  def show
    @search_date = SearchDate.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @search_date }
    end
  end

  # GET /search_dates/new
  # GET /search_dates/new.json
  def new
    @search_date = SearchDate.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @search_date }
    end
  end

  # GET /search_dates/1/edit
  def edit
    @search_date = SearchDate.find(params[:id])
  end

  # POST /search_dates
  # POST /search_dates.json
  def create
    @search_date = SearchDate.new(params[:search_date])

    respond_to do |format|
      if @search_date.save
        format.html { redirect_to @search_date, notice: 'Search date was successfully created.' }
        format.json { render json: @search_date, status: :created, location: @search_date }
      else
        format.html { render action: "new" }
        format.json { render json: @search_date.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /search_dates/1
  # PUT /search_dates/1.json
  def update
    @search_date = SearchDate.find(params[:id])

    respond_to do |format|
      if @search_date.update_attributes(params[:search_date])
        format.html { redirect_to @search_date, notice: 'Search date was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @search_date.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /search_dates/1
  # DELETE /search_dates/1.json
  def destroy
    @search_date = SearchDate.find(params[:id])
    @search_date.destroy

    respond_to do |format|
      format.html { redirect_to search_dates_url }
      format.json { head :no_content }
    end
  end
end
