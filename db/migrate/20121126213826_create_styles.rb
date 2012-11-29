class CreateStyles < ActiveRecord::Migration
  def change
    create_table :styles do |t|
      t.string :name
      t.integer :party_id
      t.string :status #available, voting, playing, played, or discarded 
      t.integer :id
      t.timestamps
    end
  end
end
