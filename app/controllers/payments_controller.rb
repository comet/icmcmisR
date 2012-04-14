class PaymentsController < ApplicationController
  filter_resource_access
  # GET /payments
  # GET /payments.xml
  def index
    if params[:patient_id]
      hash = {:query_column=>"patient_id",:value=>params[:patient_id]}
      #@payments = Payment.find_all_by_patient_id(params[:patient_id]).paginate(:page => params[:page], :per_page => 15)
      @payments = Payment.payments_specific(hash).paginate(:page => params[:page], :per_page => 15)
    elsif params[:encounter_id]
      hash = {:query_column=>"encounter_id",:value=>params[:encounter_id]}
      #@payments = Payment.find_all_by_encounter_id(params[:encounter_id]).paginate(:page => params[:page], :per_page => 15)
      @payments = Payment.payments_specific(hash).paginate(:page => params[:page], :per_page => 15)
      load_encounter_actions #to set the encounter actions
    elsif params[:custom]
      if params[:custom].eql?("pharm")
        pharmacy #load payment for pharmacy
        @payments=Payment.find_detailed.paginate(:page => params[:page], :per_page => 15)
      elsif params[:custom].eql?("tests")
        #load somthing for tests
      end
    else
      @payments = Payment.find_detailed.paginate(:page => params[:page], :per_page => 15)
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
    if session[:pay_load]
      @payment = session[:pay_load]
      session[:pay_load]=nil#clear session
    else
      @payment = Payment.new
    end
    if !request.xhr?
      if params[:encounter_id]
        load_encounter_actions #to set the encounter actions
        @encounter=params[:encounter_id]
        @particulars_special = Particular.details_of_encounter(@encounter)
      end
      if params[:payload]
        if session[:parts]
          val=session[:parts]
        else
          val=[0]
        end
        @particulars = Particular.details(val)
      elsif params[:payload2]
        @encounter=params[:payload2]
        @particulars_special = Particular.details_of_encounter(@encounter)
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
        if session[:parts]
          if Payment.bind_particulars(@payment.id, session[:parts])
            #clear the parts from the variable
            session[:parts]=nil
            if encounter
              load_encounter_actions
              format.html { redirect_to(payment_path(@payment), :notice => 'Payment was successfully Posted.') }
            else
              format.html { redirect_to(@payment, :notice => 'Payment was successfully Posted.') }
              format.xml  { render :xml => @payment, :status => :created, :location => @payment }
            end
          else
            render :action => "new"
          end
        else
          load_encounter_actions
          format.html { redirect_to(@payment, :notice => 'Payment was successfully Posted.') }
        end
      else
        format.html {
          
          session[:pay_load]=@payment
          redirect_to :action => "new",:payload=>0
        }
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