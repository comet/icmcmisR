class NhifsController < ApplicationController
  # GET /nhifs
  # GET /nhifs.xml
  def index
    if params[:patient_id]
      @patient = Patient.find(params[:patient_id])
      @nhifs = Nhif.this_patient(params[:patient_id])
      disb_id = Disbursednhif.last.id
      pivot = Pivotnhif.where("patient_id = ? AND disbursement_id = ?", params[:patient_id], disb_id)
      @balance = pivot.first.current_balance
      load_patient_actions
      #Rails.logger.debug{@current_patient.inspect}
    else
      if params[:full]
        @full = true
        @nhifs = Nhif.all
      else
        @nhifs = Nhif.daily
      end
      #Rails.logger.debug{@nhifs.inspect}
    end
    

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @nhifs }
    end
  end

  # GET /nhifs/1
  # GET /nhifs/1.xml
  def show
    @nhif = Nhif.find(params[:id])
    load_patient_actions
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @nhif }
    end
  end

  # GET /nhifs/new
  # GET /nhifs/new.xml
  def new
    @nhif = Nhif.new
    load_patient_actions
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @nhif }
    end
  end

  # GET /nhifs/1/edit
  def edit
    @nhif = Nhif.find(params[:id])
  end

  # POST /nhifs
  # POST /nhifs.xml
  def create
    @nhif = Nhif.new(params[:nhif])
    patient = params[:nhif][:patient_id]
    amount = params[:nhif][:amount_charged]
    if !Nhif.validate_amount(patient, amount.to_f)
      
      flash[:error] ='Nhif patient limit has been exceeded.'
      redirect_to(:controller=>"nhifs",:action=>'new' ) and return
      
    end
    if !Nhif.ensure_disbursement_limit( amount.to_f)
      flash[:error] ='Nhif limit has been exceeded.'
      redirect_to(:controller=>"nhifs",:action=>'new' ) and return
    end
    respond_to do |format|
      if @nhif.save
        #deduct the current balance
        @nhif.deduct_pivot(patient,amount.to_f)
        format.html { redirect_to(@nhif, :notice => 'Nhif was successfully created.') }
        format.xml  { render :xml => @nhif, :status => :created, :location => @nhif }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @nhif.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /nhifs/1
  # PUT /nhifs/1.xml
  def update
    @nhif = Nhif.find(params[:id])

    respond_to do |format|
      if @nhif.update_attributes(params[:nhif])
        format.html { redirect_to(@nhif, :notice => 'Nhif was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @nhif.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /nhifs/1
  # DELETE /nhifs/1.xml
  def destroy
    @nhif = Nhif.find(params[:id])
    @nhif.destroy

    respond_to do |format|
      format.html { redirect_to(nhifs_url) }
      format.xml  { head :ok }
    end
  end
end
