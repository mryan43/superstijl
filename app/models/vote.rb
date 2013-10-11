class Vote < ActiveRecord::Base
  attr_accessible :style_id, :user_cookie, :user_ip, :user_agent
  belongs_to :style
  
  validate :for_current_session?
  
  def update_or_create!(is_cheater)
    style.party.styles.voting.each do |style|
      style.votes.each do |vote|
        # if the user created the existing vote (matched by IP or Cookie)
        if (vote.user_cookie == user_cookie || vote.user_ip == user_ip)
          # if the user can cheat (he can vote again every 5 seconds)
          if (!is_cheater || vote.created_at > 5.seconds.ago)
            vote.style_id = style_id
            return vote.save!
          end
        end
      end
    end
    save!
  end
  
  def for_current_session?
    return style.party.styles.voting.include? style
  end

  
end
