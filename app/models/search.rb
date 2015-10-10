class Search < ActiveType::Object

  #
  #  TODO: 
  #
  #  Add a factory method that takes arguments as to 
  #  which models should be searched, and defaults to all.
  #  this could provide an easy way to add a dropdown
  #  to GUI to allow user to constrain query.
  #

  attribute :q

  validates :q, presence: true,  length: { minimum: 2 }

  before_save :build_query
  before_save :perform_query
  before_save :build_results

  attr_accessor :results

  private

  def build_query
    @query = Search::Qwery.build do # Query was conflicting with ActiveRecord, so hacked name...
      add  :song,   attribute: :title
      add  :album,  attribute: :title 
      add  :artist, attribute: :name
    end
    @query.base_query = Song.eager_load(album: :artist)
  end

  def perform_query
    unless @performed_query = @query.perform(q)
      errors.add(:q, "Error executing query")
      false
    end
  end

  def build_results
    @results = []
    @performed_query.each do |row|
      @results << Search::Result.build do 
        song_title  row.title
        album_title row.album.title
        artist_name row.album.artist.name
      end
    end
    @results
  end
end
