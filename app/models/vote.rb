class Vote < ActiveRecord::Base
  attr_accessible :style_id, :user_cookie, :user_ip, :user_agent
  belongs_to :style
  
  validate :for_current_session?
  
  def update_or_create!
    style.party.styles.voting.each do |style|
      style.votes.each do |vote|
        if (vote.user_cookie == user_cookie)
          vote.style_id = style_id
          return vote.save!
        end
      end
    end
    save!
  end
  
  def for_current_session?
    return style.party.styles.voting.include? style
  end

  
end
