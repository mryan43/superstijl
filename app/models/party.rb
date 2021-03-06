class Party < ActiveRecord::Base
  attr_accessible :name, :votes_start, :current_song_id, :current_song_start
  has_many :styles; # that's the spirit !
  belongs_to :current_song, :class_name => "Song", :foreign_key => "current_song_id"
  
  def current_style
    styles.playing.first
  end
  
  def countdown
    (STYLE_DURATION - (Time.now - votes_start)).floor
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
         style.songs.each do |song|
           song.played = false
           song.save!
         end
         style.save!
       end
     end
  end
  
  def init
  
    make_sure_we_have_enough_available_styles
    
    styles.available.sample(3).each do |style|
      style.status = "voting"
      style.save!
    end
  
  end
  
  def started?
    styles.playing.count > 0 && styles.voting.count == 3
  end
  
  def next_style(force)
    # only switch after the countdown is elapsed
    if !force && countdown > 0
      return false
    end
    transaction do
      s = current_style
      if !s.nil?
        s.status = "played"
        s.save
      end
      winner = nil
      # check what style won and switch the current style to this one
      styles.voting.each do |style|
        if winner.nil? || style.votes.count > winner.votes.count
          winner = style
        end
      end
      current_style = winner
      current_style.status = "playing"
      current_style.save
      # mark the styles that lost as discarded
      styles.voting.each do |style|
        style.status = "discarded"
        style.save
      end
    
      make_sure_we_have_enough_available_styles
    
      styles.available.sample(3).each do |style|
        style.status = "voting"
        style.save
      end
      self.next_song(true)
      self.votes_start = Time.now
      save
    end
    return true
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
                  song.played = false
                  song.file_name = file_name
                  song.file_path = file_path
                  song.save!
                end
              end
            end
          end
        end
        party.init unless party.nil?
      end  
    end
  end
  
  def next_song(force)
    if !force && Time.now - self.current_song_start < 10
      #too soon !
      return false
    end
    
    if !self.current_song.nil?
      self.current_song.played = true
      self.current_song.save!
    end
    self.current_song = self.current_style.songs.available.order("file_name").first
    self.current_song_start = Time.now
    self.save!
    return true
  end
  
  def song_offset
    (Time.now - self.current_song_start).floor
  end
  
  def votes_json
    res = {}
    styles.voting.each do |style|
      res[style.id] = style.votes.count
    end
    res.to_json
  end
  
end
