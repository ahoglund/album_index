class Artist::SearchFor
  def initialize(q)
    @q = q
  end

  attr_accessor :q

  def query
    Artist.where(bindings)
  end

  def bindings
    matches(:name, q)
  end

  def to_sql
    query.to_sql
  end
  
  private

  def matches(attribute, q)
    table[attribute].matches("%#{q}%")
  end

  def table
    Artist.arel_table
  end
end
