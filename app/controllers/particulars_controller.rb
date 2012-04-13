class ParticularsController < ApplicationController
  # GET /particulars
  # GET /particulars.xml
  def index
    @particulars = Particular.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @particulars }
    end
  end

  # GET /particulars/1
  # GET /particulars/1.xml
  def show
    @particular = Particular.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @particular }
    end
  end

  # GET /particulars/new
  # GET /particulars/new.xml
  def new
    @particular = Particular.new
    @particular.payment_id=params[:payment_id]

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @particular }
      format.js { render :nothing => true }
    end
  end

  # GET /particulars/1/edit
  def edit
    @particular = Particular.find(params[:id])
  end

  # POST /particulars
  # POST /particulars.xml
  def create
    #session[:parts]=nil
    @particular = Particular.new(params[:particular])
    if params[:particular][:quantity].blank?
      
      @particular.quantity=1 #ensure quantity is one or more
    end

    respond_to do |format|
      if @particular.save
        format.html {
          parts=[]
          if session[:parts]
            parts = session[:parts]
            parts << @particular.id
            session[:parts]=parts
          else
            parts<<@particular.id
            session[:parts]=parts
          end
          redirect_to :controller=>'payments',:action=>'new',:payload=>@particular.id}
        format.xml  { render :xml => @particular, :status => :created, :location => @particular }
        format.js {render :layout=>false}
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @particular.errors, :status => :unprocessable_entity }
        format.js {render :layout=>false}
      end
    end
  end

  # PUT /particulars/1
  # PUT /particulars/1.xml
  def update
    @particular = Particular.find(params[:id])

    respond_to do |format|
      if @particular.update_attributes(params[:particular])
        format.html { redirect_to(@particular, :notice => 'Particular was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @particular.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /particulars/1
  # DELETE /particulars/1.xml
  def destroy
    @particular = Particular.find(params[:id])
    @particular.destroy

    respond_to do |format|
      format.html { redirect_to(particulars_url) }
      format.xml  { head :ok }
    end
  end
end
