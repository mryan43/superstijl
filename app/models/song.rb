class Song < ActiveRecord::Base
  attr_accessible  :duration, :file_name, :file_path, :style_id, :played
  belongs_to :style
  
  scope :available, where(:played => false)
end
