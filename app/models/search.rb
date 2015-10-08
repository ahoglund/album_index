class Search < ActiveType::Object

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
    [Song, Album, Artist]
  end

  def split_query
    @split_query ||= q.split(/\s+/)
  end

  def query
    parts = []
    bindings = []
    relation = Song.joins(album: :artist)
    split_query.each do |word|
      escaped_word = escape_for_like_query(word)
      search_targets.each do |search_target|
        parts << "#{search_target}::SearchFor".classify.constantize.new(escaped_word).bindings.to_sql
      end
      relation = relation.where(parts.join(' OR '))
    end
    relation
  end

  def escape_for_like_query(phrase)
    phrase.gsub("%", "\\%").gsub("_", "\\_")
  end

  def search_result
    Struct.new(:song_title, :album_title, :artist_name)
  end
end

