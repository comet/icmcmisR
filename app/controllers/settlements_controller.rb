class SettlementsController < ApplicationController
  # GET /settlements
  # GET /settlements.xml
  def index
    current_plan
    if @current_plan
      @settlements = Settlement.find_detailed_set(@current_plan)
      #Rails.logger.debug{@settlements.inspect}
    end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @settlements }
    end
  end

  # GET /settlements/1
  # GET /settlements/1.xml
  def show
    @settlement = Settlement.find(params[:id])
    current_plan
    @settlement_parts = Settlement.find_detailed_parts(params[:id])
    if @settlement_parts
      Rails.logger.debug{@settlement_parts.inspect}
    else
      flash[:error]="No such settlement found"
    end
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @settlement }
    end
  end

  # GET /settlements/new
  # GET /settlements/new.xml
  def new
    #load the expected claimparticulars
    if params[:load]
      @settlement = session[:load]
      session[:load]=nil
    else
      @settlement = Settlement.new
    end
    current_plan
    if @current_plan
      @claimparticulars = ClaimParticular.load_pending(@current_plan.name)
    end

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @settlement }
    end
  end

  # GET /settlements/1/edit
  def edit
    @settlement = Settlement.find(params[:id])
  end

  # POST /settlements
  # POST /settlements.xml
  def create
    @settlement = Settlement.new(params[:settlement])
    respond_to do |format|
      if @settlement.save
        current_plan
        if Settlement.bind_to_claims(@settlement.id,ClaimParticular.load_pending(@current_plan.name))
          format.html { redirect_to(@settlement, :notice => 'Settlement was successfully created.') }
          format.xml  { render :xml => @settlement, :status => :created, :location => @settlement }
        end
      else
        format.html {
          session[:load]=@settlement
          redirect_to :action => "new",:load=>0}
        format.xml  { render :xml => @settlement.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /settlements/1
  # PUT /settlements/1.xml
  def update
    @settlement = Settlement.find(params[:id])

    respond_to do |format|
      if @settlement.update_attributes(params[:settlement])
        format.html { redirect_to(@settlement, :notice => 'Settlement was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @settlement.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /settlements/1
  # DELETE /settlements/1.xml
  def destroy
    @settlement = Settlement.find(params[:id])
    @settlement.destroy

    respond_to do |format|
      format.html { redirect_to(settlements_url) }
      format.xml  { head :ok }
    end
  end
end
