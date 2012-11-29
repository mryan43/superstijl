class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.integer :id
      t.string :file_name
      t.string :file_path
      t.integer :duration
      t.integer :style_id

      t.timestamps
    end
  end
end
