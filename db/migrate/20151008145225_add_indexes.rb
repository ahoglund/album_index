class AddIndexes < ActiveRecord::Migration
  def change
  	add_index :albums, :artist_id
  	add_index :songs, :album_id
  end
end
