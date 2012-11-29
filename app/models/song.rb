class Song < ActiveRecord::Base
  attr_accessible  :duration, :file_name, :file_path, :style_id
  belongs_to :style
end
