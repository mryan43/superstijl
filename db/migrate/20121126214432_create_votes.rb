class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :style_id
      t.string :user_id

      t.timestamps
    end
  end
end
