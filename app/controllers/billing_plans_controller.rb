class BillingPlansController < ApplicationController
  # GET /billing_plans
  # GET /billing_plans.xml
  def index
    if params[:bid]
      @claims=BillingPlan.load_claims(params[:bid]).paginate(:page => params[:page], :per_page => 15)
      current_plan
    else
      @billing_plans = BillingPlan.paginate(:page => params[:page], :per_page => 15).all
    end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @billing_plans }
    end
  end

  # GET /billing_plans/1
  # GET /billing_plans/1.xml
  def show
    @billing_plan = BillingPlan.find(params[:id])
    if @billing_plan
      session[:plan]=@billing_plan
      current_plan
      @claims=BillingPlan.load_claims(@current_plan.id.to_i)
      @setts = Settlement.find_detailed_set(@current_plan)
      Rails.logger.debug{@setts.inspect}
    end
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @billing_plan }
    end
  end

  # GET /billing_plans/new
  # GET /billing_plans/new.xml
  def new
    @billing_plan = BillingPlan.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @billing_plan }
    end
  end

  # GET /billing_plans/1/edit
  def edit
    @billing_plan = BillingPlan.find(params[:id])
  end

  # POST /billing_plans
  # POST /billing_plans.xml
  def create
    @billing_plan = BillingPlan.new(params[:billing_plan])

    respond_to do |format|
      if @billing_plan.save
        format.html { redirect_to(@billing_plan, :notice => 'Billing plan was successfully created.') }
        format.xml  { render :xml => @billing_plan, :status => :created, :location => @billing_plan }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @billing_plan.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /billing_plans/1
  # PUT /billing_plans/1.xml
  def update
    @billing_plan = BillingPlan.find(params[:id])

    respond_to do |format|
      if @billing_plan.update_attributes(params[:billing_plan])
        format.html { redirect_to(@billing_plan, :notice => 'Billing plan was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @billing_plan.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /billing_plans/1
  # DELETE /billing_plans/1.xml
  def destroy
    @billing_plan = BillingPlan.find(params[:id])
    @billing_plan.destroy

    respond_to do |format|
      format.html { redirect_to(billing_plans_url) }
      format.xml  { head :ok }
    end
  end
end
