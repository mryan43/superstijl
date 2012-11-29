class Vote < ActiveRecord::Base
  attr_accessible :style_id, :user_id
  belongs_to :style
  
  validate :voting_open
  validate :only_one_vote
  
  def voting_open
    if !style.party.styles.voting.include? style
      errors.add(:style, "Votes for this style are closed, the styles have been refreshed, please vote again :)")
    end
  end
  
  def only_one_vote
    style.party.styles.voting.each do |style|
      style.votes.each do |vote|
        if (vote.user_id == user_id)
          errors.add(:style, "You already voted for this style")
        end
      end
    end
  end
  
end
