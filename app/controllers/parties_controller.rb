class PartiesController < ApplicationController
  
  def start
    @party = Party.find(params[:id])
    @party.start
    redirect_to @party 
  end
  
  def index
    @parties = Party.all
  end
  
  def show 
    @main = is_main?
    @party = Party.find(params[:id])
  end  
  
  def next_style
    
    @party = Party.find(params[:id])
    nexted = @party.next_style(is_main?)
    @party.save
    respond_to do |format|
      format.json { render :json => "ok" }
    end
    if nexted
      PrivatePub.publish_to "/party/next_style", :winner => @party.current_style.name
    end
  end
end
