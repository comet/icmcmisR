class SessionsController < ApplicationController

  before_filter :login_required,:only=>['change_password']
  def index
    redirect_to :action=>'login'
  end
  def login
    @session=nil
    if request.post?
      @login=User.find_by_username(params[:user][:login])

      if @login
      @session = Session.new(:user_id=>@login.id)
      @session.login_ip=request.remote_ip
      if session[:user] = User.authenticate(params[:user][:login], params[:user][:password])
        @session.login_status="success"
        if @session.save
        flash[:notice]  = "Welcome "+params[:user][:login]+",Your Login was successful"
        #Rails.logger.debug{"Login was successful for "+params[:user][:login].to_s}
        if session[:return_to]
          @return =session[:return_to]
            session[:return_to] = nil
         redirect_to(@return,:notice=>"Login was successful")
        else
        redirect_to :controller=>'dashboard',:action => 'index'
        end
        end
      else
        @session.login_status="failed"
        if @session.save
        flash[:error] = "Login failed,please try again."
       # Rails.logger.debug{"Login failed for user "+params[:user][:login].to_s}
        end
      end
    else
      flash[:error] = "Login failed,please try again."
       # Rails.logger.debug{"Login failed for user "+params[:user][:login].to_s}
    end
    end
  end

  def logout
    @session=Session.find_all_by_user_id(session[:user].id).last
    if @session
      @session.time_out= DateTime.now
    end
    session[:user] = nil
    session[:return_to] = nil

    if @session.save
    flash[:notice] = 'You have been successfully Logged out'
    else
      flash[:error] = 'You have been Logged out but with errors'
      Rails.logger.error{"Session logout details were not updated correctly "}
      #Rails.logger.error{@session.inspect}
    end
    redirect_to root_url
  end

  def forgot_password
    if request.post?
      u= User.find_by_email(params[:user][:email])
      if u and u.send_new_password
        flash[:message]  = "A new password has been sent by email."
        redirect_to :action=>'login'
      else
        flash[:error]  = "Couldn't send password"
      end
    end
  end

  def change_password
    @user=session[:user]
    if request.post?
      @user.update_attributes(:password=>params[:user][:password], :password_confirmation => params[:user][:password_confirmation])
      if @user.save
        flash[:notice
        ]="Password Changed"
      end
    end
  end
end
