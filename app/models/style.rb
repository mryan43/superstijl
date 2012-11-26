class Style < ActiveRecord::Base
  attr_accessible :name
  belongs_to :party
  
  scope :played, where(:status => "played")
  scope :available, where(:status => "available")
  scope :discarded, where(:status => "discarded")
  scope :voting, where(:status => "voting")
  scope :playing, where(:status => "playing")
  
end
