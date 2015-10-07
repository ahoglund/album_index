require 'ostruct'

class Search < ActiveType::Object

  attribute :q

  after_save :get_results

  attr_accessor :results

  private

  def get_results
    @results = []
    Song.find_each do |song|
      if song.title =~ /#{q}/ || 
      	 song.album.title =~ /#{q}/ || 
      	 song.album.artist.name =~ /#{q}/
        song_struct = OpenStruct.new(
          song_title: song.title,
          album_title: song.album.title,
          artist_name: song.album.artist.name
        )
        @results << song_struct
      end
    end
  end


  def split_query
    q.split(/\s+/)
  end

  def matches
    parts = []
    bindings = []
    split_query.each do |word|
      escaped_word = escape_for_like_query(word)
      parts << 'body LIKE ? OR title LIKE ?'
      bindings << escaped_word
      bindings << escaped_word
    end
    Note.where(parts.join(' OR '), *bindings)
  end
end
