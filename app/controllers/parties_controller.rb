class PartiesController < ApplicationController
  
  def index
    @parties = Party.all
  end
  
  def show 
    @party = Party.find(params[:party_id])
  end  
  
  def next_style
    
    @party = Party.find(params[:party_id])
    @party.next_style
    @party.save
    respond_to do |format|
      format.html { redirect_to @party }
    end
  
  end
end
