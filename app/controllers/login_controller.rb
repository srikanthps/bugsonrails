class LoginController < ApplicationController

  def authenticate
    if (params[:user_id])
      @members = Member.all(:conditions => "nickname = '#{params[:user_id]}'")
      logger.info " **** Logged in "  + @members[0].inspect
      if ( @members[0] )
        cookies[:user_id] = {:value => params[:user_id], :expires => 30.days.from_now }
        session[:user] = @members[0]
        redirect_to :controller => session[:intended_controller], :action => session[:intended_action]
      else
        flash[:error] = "User not found"
        redirect_to :action=> "login"
      end
    end
  end

end