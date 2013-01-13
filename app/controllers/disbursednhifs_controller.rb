class DisbursednhifsController < ApplicationController
  # GET /disbursednhifs
  # GET /disbursednhifs.xml
  def index
    @disbursednhifs = Disbursednhif.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @disbursednhifs }
    end
  end

  # GET /disbursednhifs/1
  # GET /disbursednhifs/1.xml
  def show
    @disbursednhif = Disbursednhif.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @disbursednhif }
    end
  end

  # GET /disbursednhifs/new
  # GET /disbursednhifs/new.xml
  def new
    @disbursednhif = Disbursednhif.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @disbursednhif }
    end
  end

  # GET /disbursednhifs/1/edit
  def edit
    @disbursednhif = Disbursednhif.find(params[:id])
  end

  # POST /disbursednhifs
  # POST /disbursednhifs.xml
  def create
    @disbursednhif = Disbursednhif.new(params[:disbursednhif])

    respond_to do |format|
      if @disbursednhif.save
        #create a pivot account for all nhif patients
        if !@disbursednhif.update_pivot
          Rails.logger.error {"Failed updating the pivot table for nhif "}
        end
        format.html { redirect_to(@disbursednhif, :notice => 'Disbursednhif was successfully created.') }
        format.xml  { render :xml => @disbursednhif, :status => :created, :location => @disbursednhif }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @disbursednhif.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /disbursednhifs/1
  # PUT /disbursednhifs/1.xml
  def update
    @disbursednhif = Disbursednhif.find(params[:id])

    respond_to do |format|
      if @disbursednhif.update_attributes(params[:disbursednhif])
        format.html { redirect_to(@disbursednhif, :notice => 'Disbursednhif was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @disbursednhif.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /disbursednhifs/1
  # DELETE /disbursednhifs/1.xml
  def destroy
    @disbursednhif = Disbursednhif.find(params[:id])
    @disbursednhif.destroy

    respond_to do |format|
      format.html { redirect_to(disbursednhifs_url) }
      format.xml  { head :ok }
    end
  end
end
