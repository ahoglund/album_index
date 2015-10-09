class Search::Qwery

  def self.build(&block)
    search = new
    search.instance_eval(&block)
    search
  end

  attr_accessor :relation

  def initialize 
  	@search_targets = []
  end

  def add(search_target, attributes)
    @search_targets <<  { search_target: search_target }.merge(attributes)
  end

  def perform(q)
    return false if @relation.nil?
    split_words(q) && query
  end

  private
  
  def split_words(q)
    @words ||= q.split(/\s+/)
  end

  def query
    @words.each do |word|
      parts = []
      escaped_word = escape_for_like(word)
      @search_targets.each do |target|
        parts << Search::Target.new(target[:search_target], target[:attributes], escaped_word).bindings.to_sql
      end
      @relation = @relation.where(parts.join(' OR '))
    end
    @relation
  end

  def escape_for_like(phrase)
    phrase.gsub("%", "\\%").gsub("_", "\\_")
  end
end