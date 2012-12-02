class AddRemainingTimeToParty < ActiveRecord::Migration
  def change
     add_column :parties, :votes_start, :timestamp
  end
end
