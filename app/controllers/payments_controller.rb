class PaymentsController < ApplicationController
  filter_resource_access
  # GET /payments
  # GET /payments.xml
  def index
    if params[:patient_id]
      @payments = Payment.find_all_by_patient_id(params[:patient_id])
    elsif params[:encounter_id]
      @payments = Payment.find_all_by_encounter_id(params[:encounter_id])
      load_encounter_actions #to set the encounter actions
    elsif params[:custom]
      if params[:custom].eql?("pharm")
        pharmacy #load payment for pharmacy
        @payments=Payment.all
      elsif params[:custom].eql?("tests")
        #load somthing for tests
      end
    else
      @payments = Payment.all
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @payments }
    end
  end

  # GET /payments/1
  # GET /payments/1.xml
  def show
    @payment = Payment.find_detailed(params[:id])
    #@particulars = Payment.includes[:particulars]
    if params[:encounter_id]
      load_encounter_actions #to set the encounter actions
    end
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @payment }
    end
  end

  # GET /payments/new
  # GET /payments/new.xml
  def new
    @payment = Payment.new
    if !request.xhr?
      if params[:encounter_id]
        load_encounter_actions #to set the encounter actions
      elsif params[:payload]
        @particulars = Particular.details(session[:parts])
      end
    end
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @payment }
      format.js {render :layout => false}
    end
  end

  # GET /payments/1/edit
  def edit
    @payment = Payment.find(params[:id])
  end

  # POST /payments
  # POST /payments.xml
  def create
    @payment = Payment.new(params[:payment])
    encounter=params[:payment][:encounter_id]
    respond_to do |format|
      if @payment.save
        if Payment.bind_particulars(@payment.id, session[:parts])
        #clear the parts from the variable
        session[:parts]=nil
        if encounter
          format.html { redirect_to(encounter_payment_path(encounter,@payment), :notice => 'Payment was successfully Posted.') }
        else
          format.html { redirect_to(@payment, :notice => 'Payment was successfully Posted.') }
          format.xml  { render :xml => @payment, :status => :created, :location => @payment }
        end
        else
          render :action => "new",:payload=>0
        end
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @payment.errors, :status => :unprocessable_entity }
        format.js {render :layout => false}
      end
    end
  end

  # PUT /payments/1
  # PUT /payments/1.xml
  def update
    @payment = Payment.find(params[:id])

    respond_to do |format|
      if @payment.update_attributes(params[:payment])
        format.html { redirect_to(@payment, :notice => 'Payment was successfully updated.') }
        format.xml  { head :ok }
        format.js {render :layout => false}
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @payment.errors, :status => :unprocessable_entity }
        format.js {render :layout => false}
      end
    end
  end

  # DELETE /payments/1
  # DELETE /payments/1.xml
  def destroy
    @payment = Payment.find(params[:id])
    @payment.destroy

    respond_to do |format|
      format.html { redirect_to(payments_url) }
      format.xml  { head :ok }
      format.js {render :layout => false}
    end
  end
end