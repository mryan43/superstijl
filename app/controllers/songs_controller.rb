class SongsController < ApplicationController
  
  def show
    @song = Song.find(params[:id])
    send_file @song.file_path, :filename => "#{@song.id}.mp3", 
       :disposition => 'inline', :type => "audio/mpeg"
  end
  
end
