class Party < ActiveRecord::Base
  attr_accessible :name
  has_many :styles; # that's the spirit !
  
  def start
  end
  
  def next_style
    current_style.status = "played"
    current_style.save!
    winner = nil
    # check what style won and switch the current style to this one
    styles.voting.each do |style|
      if winner.nil? || style.votes.count > winner.votes.count
        winner = style
      end
    end
    current_style = winner
    current_style.status = "playing"
    current_style.save!
    # mark the styles that lost as discarded
    styles.voting.each do |style|
      if style != winner
        style.status = "discarded"
        style.save!
      end
    end
    #make sure there are always 3 types to vote for
    if styles.available.count < 3
      styles.discarded.each do |style|
        style.status = "available"
        style.save!
      end
      if styles.available.count < 3
        styles.played.each do |style|
          style.status = "available"
          style.save!
        end
      end
    end
    styles.available.sample(3).each do |style|
      style.status = "voting"
      style.save!
    end
    
  end
  
end
