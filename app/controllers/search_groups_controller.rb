class SearchGroupsController < ApplicationController
  # GET /search_groups
  # GET /search_groups.json
  def index
    # @search_groups = SearchGroup.all
		@search_groups = SearchGroup.paginate :page=>params[:page], :order=>'created_at desc',
			:per_page => 50

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @search_groups }
    end
  end

  # GET /search_groups/1
  # GET /search_groups/1.json
  def show
    @search_group = SearchGroup.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @search_group }
    end
  end

  # GET /search_groups/new
  # GET /search_groups/new.json
  def new
    @search_group = SearchGroup.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @search_group }
    end
  end

  # GET /search_groups/1/edit
  def edit
    @search_group = SearchGroup.find(params[:id])
  end

  # POST /search_groups
  # POST /search_groups.json
  def create
    @search_group = SearchGroup.new(params[:search_group])

    respond_to do |format|
      if @search_group.save
        format.html { redirect_to @search_group, notice: 'Search group was successfully created.' }
        format.json { render json: @search_group, status: :created, location: @search_group }
      else
        format.html { render action: "new" }
        format.json { render json: @search_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /search_groups/1
  # PUT /search_groups/1.json
  def update
    @search_group = SearchGroup.find(params[:id])

    respond_to do |format|
      if @search_group.update_attributes(params[:search_group])
        format.html { redirect_to @search_group, notice: 'Search group was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @search_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /search_groups/1
  # DELETE /search_groups/1.json
  def destroy
    @search_group = SearchGroup.find(params[:id])
    @search_group.destroy

    respond_to do |format|
      format.html { redirect_to search_groups_url }
      format.json { head :no_content }
    end
  end
	
	  # GET /search_groups/1/execute
  def execute
		search_qty = 0
		result_qty = 0
    @search_group = SearchGroup.find(params[:id])
		@search_group.searches.each do |search|
			begin
				result_qty += search.execute
				search_qty += 1
			rescue
				puts "Error en el execute del search id:" + search.id
			end
		end
    
   respond_to do |format|
     if search_qty
       format.html { redirect_to @search_group, notice: 'Group Search:'+ @search_group.name + ': ' + search_qty.to_s + ' searches were successfully executed.' }
       format.json { head :no_content }
     else
       format.html { render action: "show" }
       format.json { render json: @search_group.errors, status: :unprocessable_entity }
     end
   end
  end
end
