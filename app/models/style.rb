class Style < ActiveRecord::Base
  attr_accessible :name, :party_id, :status
  belongs_to :party
  has_many :songs
  has_many :votes
  
  scope :played, where(:status => "played")
  scope :available, where(:status => "available")
  scope :discarded, where(:status => "discarded")
  scope :voting, where(:status => "voting")
  scope :playing, where(:status => "playing")
  
  before_save :default_values
  def default_values
    self.status ||= "available"
  end
  
end
