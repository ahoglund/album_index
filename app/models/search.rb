class Search < ActiveType::Object

  attribute :q

  validates_presence_of :q

  before_save :build_results

  attr_accessor :results
  
  private

  def build_results
    @results = [  ]
    query.each do |song|
      @results << search_result.new(song.title,song.album.title,song.album.artist.name)
    end
  end

  def query
    @query ||= Song.joins(album: :artist).where("songs.title LIKE '%#{q}%' OR albums.title LIKE '%#{q}%' OR artists.name LIKE '%#{q}%'")
  end

  def search_result
    Struct.new(:song_title, :album_title, :artist_name)
  end
end
