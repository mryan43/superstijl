class AddCurrentSongToParty < ActiveRecord::Migration
  def change
    add_column :parties, :current_song_id, :integer
    add_column :parties, :current_song_start, :timestamp
    add_column :songs, :played, :boolean
  end
end
