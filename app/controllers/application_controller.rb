class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :set_user_id
  
  def set_user_id
  
    # this cookie will be used to prevent people to vote multiple times.
    # of course a user cleaning his cookies could vote multiple times.
    # If you feel something is wrong, detect cheaters with votes ips 
    # and user_agent in the vote model
    if cookies[:rand].nil?
      cookies[:rand] = SecureRandom.hex(8)
    end
    
    if "true" == params[:main]
      cookies[:main] = "true"
    end
    
    if "false" == params[:main]
      cookies[:main] = false
    end
    
    if "true" == params[:cheat]
      cookies[:cheat] = "true"
    end
    
    if "false" == params[:cheat]
      cookies[:cheat] = false
    end
    
    @cheater = is_cheater?
    @main = is_main?
  end
  
  def is_main?
    cookies[:main] == "true"
  end
  
  def is_cheater?
    cookies[:cheat] == "true"
  end
  
end
