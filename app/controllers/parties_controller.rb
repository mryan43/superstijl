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
    @party = Party.find(params[:id])
  end  
  
  def next_style
    
    @party = Party.find(params[:id])
    @party.next_style
    @party.save
    respond_to do |format|
      format.html { redirect_to @party }
    end
  
  end
end
