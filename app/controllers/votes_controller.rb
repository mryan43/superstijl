class VotesController < ApplicationController
  
  def create
    @style = Style.find(params[:style_id])
    vote = Vote.new
    vote.user_agent = request.env['HTTP_USER_AGENT']
    vote.user_ip = request.remote_ip
    vote.user_cookie = cookies[:rand]
    vote.style = @style
    if !vote.for_current_session?
      flash[:notice] = "Try again with the current styles :)"
      redirect_to @style.party
      return
    else
      vote.update_or_create!
      respond_to do |format|
        format.json { render :json => "ok" }
      end
    end
    p @style.party.votes_json
    PrivatePub.publish_to "/votes/update", :votes => @style.party.votes_json
  end
end
