class Party < ActiveRecord::Base
  attr_accessible :name
  has_many :styles; # that's the spirit !
  
  def current_style
    styles.playing.first
  end
  
  def make_sure_we_have_enough_available_styles
    #make sure there are always 3 types to vote for
    if styles.available.count < 3
      styles.discarded.each do |style|
        style.votes.each do |vote|
          vote.destroy
        end
        style.status = "available"
        style.save!
      end
    end
    if styles.available.count < 3
       styles.played.each do |style|
         style.votes.each do |vote|
           vote.destroy
         end
         style.status = "available"
         style.save!
       end
     end
  end
  
  def start
    make_sure_we_have_enough_available_styles
    
    s = styles.find_by_name "Intro"
    if s.nil?
      s = styles.sample
    end
    s.status = "playing"
    s.save!
    
    styles.available.sample(3).each do |style|
      style.status = "voting"
      style.save!
    end
  end
  
  def started?
    styles.playing.count > 0 && styles.voting.count == 3
  end
  
  def next_style
    s = current_style
    s.status = "played"
    s.save!
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
      style.status = "discarded"
      style.save!
    end
    
    make_sure_we_have_enough_available_styles
    
    styles.available.sample(3).each do |style|
      style.status = "voting"
      style.save!
    end
    
  end
  
  def self.scan

    Dir.foreach(PARTIES_PATH) do |party_name|
      party_path = PARTIES_PATH+"/"+party_name
      if File.directory?(party_path) && party_name[0,1] != "."
        party = Party.find_by_name(party_name)
        if party.nil?
          party = Party.new
          party.name = party_name
          party.save!
        end
        Dir.foreach(party_path) do |style_name|
          style_path = party_path+"/"+style_name
          if File.directory?(style_path) && style_name[0,1] != "."
            style = party.styles.where(:name => style_name)
            if style.empty?
              style = Style.new
              style.name = style_name
              style.party = party
              style.save!
            else
              style = style[0]
            end
            Dir.foreach(style_path) do |file_name|
              file_path = style_path+"/"+file_name
              if File.file?(file_path) && file_name[0,1] != "."
                song = style.songs.where(:file_name => file_name)
                if song.empty?
                  song = song.new
                  song.file_name = file_name
                  song.file_path = file_path
                  song.save!
                end
              end
            end
          end
        end
      end  
    end
  end
  
  def votes_json
    res = {}
    styles.voting.each do |style|
      res[style.id] = style.votes.count
    end
    res.to_json
  end
  
end
