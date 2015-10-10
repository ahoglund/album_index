class Search::Target
  def initialize(target,attribute)
    # TODO:
    # should enhance to take multiple attributes to
    # search against and build the bindings 
    # dynamically.
    @target = target
    @attribute = attribute
  end

  attr_accessor :attribute

  def like(q)
    table[attribute].matches("%#{q}%").to_sql
  end

  private

  def table
    @target.to_s.classify.constantize.arel_table
  end
end
