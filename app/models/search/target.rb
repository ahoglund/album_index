class Search::Target
  def initialize(target,attribute,q)
    # TODO:
    # should enhance to take multiple attributes to
    # search against and build the bindings 
    # dynamically.
    @attribute = attribute
    @q = q
    @target = target
  end

  attr_accessor :q

  def query
    @target.to_s.classify.constantize.where(bindings)
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
    @target.to_s.classify.constantize.arel_table
  end
end
