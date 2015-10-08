class Album::SearchFor
  def initialize(q)
    @q = q
  end

  attr_accessor :q

  def query
    Album.where(bindings)
  end

  def bindings
    matches(:title, q)
  end

  def to_sql
    query.to_sql
  end

  private

  def matches(attribute, q)
    table[attribute].matches("%#{q}%")
  end

  def table
    Album.arel_table
  end
end
