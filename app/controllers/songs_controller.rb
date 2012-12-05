require 'mime/types'

class SongsController < ApplicationController
  
  def show
    @song = Song.find(params[:id])
    extension = File.extname(@song.file_path)
    send_file @song.file_path, :filename => "#{@song.id}#{extension}", 
       :disposition => 'inline', :type => MIME::Types.type_for(@song.file_path).first
  end
  
end
