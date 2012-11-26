class VotesController < ApplicationController
  def create
    @style = Style.get(params[:style_id])
    @cookies[:user_id]
    
  end
end
