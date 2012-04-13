class ClaimParticularsController < ApplicationController
  # GET /claim_particulars
  # GET /claim_particulars.xml
  def index
    @claim_particulars = ClaimParticular.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @claim_particulars }
    end
  end

  # GET /claim_particulars/1
  # GET /claim_particulars/1.xml
  def show
    @claim_particular = ClaimParticular.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @claim_particular }
    end
  end

  # GET /claim_particulars/new
  # GET /claim_particulars/new.xml
  def new
    @claim_particular = ClaimParticular.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @claim_particular }
    end
  end

  # GET /claim_particulars/1/edit
  def edit
    @claim_particular = ClaimParticular.find(params[:id])
  end

  # POST /claim_particulars
  # POST /claim_particulars.xml
  def create
    @claim_particular = ClaimParticular.new(params[:claim_particular])

    respond_to do |format|
      if @claim_particular.save
        format.html { redirect_to(@claim_particular, :notice => 'Claim particular was successfully created.') }
        format.xml  { render :xml => @claim_particular, :status => :created, :location => @claim_particular }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @claim_particular.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /claim_particulars/1
  # PUT /claim_particulars/1.xml
  def update
    @claim_particular = ClaimParticular.find(params[:id])

    respond_to do |format|
      if @claim_particular.update_attributes(params[:claim_particular])
        format.html { redirect_to(@claim_particular, :notice => 'Claim particular was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @claim_particular.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /claim_particulars/1
  # DELETE /claim_particulars/1.xml
  def destroy
    @claim_particular = ClaimParticular.find(params[:id])
    @claim_particular.destroy

    respond_to do |format|
      format.html { redirect_to(claim_particulars_url) }
      format.xml  { head :ok }
    end
  end
end
