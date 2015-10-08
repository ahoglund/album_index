class Search < ActiveType::Object

  #
  #  TODO: 
  #
  #  Add a factory method that takes arguments as to 
  #  which models should be searched, and defaults to all.
  #  this could provide an easy way to add a dropdown
  #  to GUI to allow user to contrain query.
  #

  attribute :q

  validates :q, presence: true,  length: { minimum: 2 }

  before_save :build_results

  attr_accessor :results

  private

  def build_results
    @results = []
    query.each do |song|
      @results << search_result.new(song.title,song.album.title,song.album.artist.name)
    end
  end

  def search_targets
    [:song, :album, :artist]
  end

  def words
    @words ||= q.split(/\s+/)
  end

  def query
    relation = Song.joins(album: :artist)
    words.each do |word|
      parts = []
      escaped_word = escape_for_like(word)
      search_targets.each do |search_target|
        parts << "#{search_target}::SearchFor".classify.constantize.new(escaped_word).bindings.to_sql
      end
      relation = relation.where(parts.join(' OR '))
    end
    relation
  end

  def escape_for_like(phrase)
    phrase.gsub("%", "\\%").gsub("_", "\\_")
  end

  def search_result
    Struct.new(:song_title, :album_title, :artist_name)
  end
end
