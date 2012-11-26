class Vote < ActiveRecord::Base
  attr_accessible :party_id, :style_id, :user_id
  belongs_to :party
  belongs_to :style
  
  validate :voting_open
  validate :only_one_vote
  
  def voting_open
    if !party.voting_styles.include? style
      errors.add(:style, "Les votes pour ce style sont terminés")
    end
  end
  
  def only_one_vote
    party.voting_style.each do |style|
      style.votes.each do |vote|
        if (vote.user_id == user_id)
          errors.add(:style, "Vous avez déjà voté parmis les styles proposés actuellement")
        end
      end
    end
  end
  
end
