class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :style_id
      t.string :user_ip
      t.string :user_cookie
      t.string :user_agent

      t.timestamps
    end
  end
end
