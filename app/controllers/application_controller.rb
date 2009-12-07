# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base

  before_filter  :check_authentication, :except => [:login, :authenticate]

  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  def check_authentication
    session[:intended_action] = action_name
    session[:intended_controller] = controller_name

    if ( !cookies[:user_id] )
      redirect_to :controller => "login",  :action => "login"
    else

      @members = Member.all(:conditions => "nickname = '#{cookies[:user_id]}'")

      if ( @members[0] )
        session[:user] = @members[0]
      else
        redirect_to :controller => "login",  :action => "login"
      end

    end
  end

end
