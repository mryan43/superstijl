class HomeController < ApplicationController
  
  def index
    @parties = Party.all
  end
  
  def scan
    Party.scan
    redirect_to :root
  end
  
end
