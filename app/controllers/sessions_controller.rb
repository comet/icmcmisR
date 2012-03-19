class SessionsController < ApplicationController

  before_filter :login_required,:only=>['change_password']
  def index
    redirect_to :action=>'login'
  end
  def login
    if request.post?
      if session[:user] = User.authenticate(params[:user][:login], params[:user][:password])
        flash[:message]  = "Login successful"
        Rails.logger.debug{"Login was successful for "+params[:user][:login].to_s}
        if session[:return_to]
         redirect_to (session[:return_to],:notice=>"Login was successful")
        else
        redirect_to :controller=>'dashboard',:action => 'index'
        end
      else
        flash[:error] = "Login failed,please try again."
        Rails.logger.debug{"Login failed for user "+params[:user][:login].to_s}
      end
    end
  end

  def logout
    session[:user] = nil
    flash[:notice] = 'You have been successfully Logged out'
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
