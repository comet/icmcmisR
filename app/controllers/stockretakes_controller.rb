class StockretakesController < ApplicationController
  before_filter :pharmacy
  # GET /stockretakes
  # GET /stockretakes.xml
  def index
    @stockretakes = Stockretake.find_detailed
    Rails.logger.debug{@stockretakes.inspect}
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @stockretakes }
    end
  end

  # GET /stockretakes/1
  # GET /stockretakes/1.xml
  def show
    @stockretake = Stockretake.find_detailed(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @stockretake }
    end
  end

  # GET /stockretakes/new
  # GET /stockretakes/new.xml
  def new
    if params[:stid]
      @drug = Payable.find(params[:stid])
      if @drug
        @stockretake = Stockretake.new
      else
        flash[:error]="Please choose a drug to update its quantity"
        redirect_to drugs_path
      end
    else
      flash[:error]="Please choose a drug to update its quantity"
      redirect_to drugs_path
    end
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @stockretake }
    end
  end

  # GET /stockretakes/1/edit
  def edit

    if params[:id]
      @drug = Payable.find(params[:id])
      if @drug
        @stockretake = Stockretake.find(params[:id])
      else
        flash[:error]="Please choose an item to update its quantity"
        redirect_to stockretake_path(params[:id])
      end
    else
      flash[:error]="Please choose an item to update its quantity"
      redirect_to stockretake_path(params[:id])
    end
  end

  # POST /stockretakes
  # POST /stockretakes.xml
  def create
    @stockretake = Stockretake.new(params[:stockretake])

    respond_to do |format|
      if @stockretake.save
        @stockretake.update_item
        format.html { redirect_to(@stockretake, :notice => 'Stock was successfully updated.') }
        format.xml  { render :xml => @stockretake, :status => :created, :location => @stockretake }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @stockretake.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /stockretakes/1
  # PUT /stockretakes/1.xml
  def update
    @stockretake = Stockretake.find(params[:id])

    respond_to do |format|
      if @stockretake.update_attributes(params[:stockretake])
        format.html { redirect_to(@stockretake, :notice => 'Stock was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @stockretake.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /stockretakes/1
  # DELETE /stockretakes/1.xml
  def destroy
    @stockretake = Stockretake.find(params[:id])
    @stockretake.destroy

    respond_to do |format|
      format.html { redirect_to(stockretakes_url) }
      format.xml  { head :ok }
    end
  end
end
