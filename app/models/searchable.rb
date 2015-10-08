class Searchable
  def initialize(searchable, q, attribute)
    # TODO:
    # should enhance to take multiple attributes to
    # search against and build the bindings 
    # dynamically.
    @attribute = attribute
    @q = q
    @searchable = searchable
  end

  attr_accessor :q

  def query
    @searchable.to_s.classify.constantize.where(bindings)
  end

  def bindings
    matches(@attribute.to_sym, q)
  end

  def to_sql
    query.to_sql
  end

  private

  def matches(attribute, q)
    table[attribute].matches("%#{q}%")
  end

  def table
    @searchable.to_s.classify.constantize.arel_table
  end
end
