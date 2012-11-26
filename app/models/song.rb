class Song < ActiveRecord::Base
  attr_accessible :artist, :duration, :file_name, :file_path, :style_id, :title
  belongs_to :style
end
