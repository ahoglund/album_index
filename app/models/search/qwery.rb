class Search::Qwery

  def self.build(&block)
    search = new
    search.instance_eval(&block)
    search
  end

  attr_accessor :base_query

  def initialize
    @search_targets = []
  end

  def add(search_target, attribute)
    @search_targets << { search_target: search_target }.merge(attribute)
  end

  def perform(q)
    return false if @base_query.nil?
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
        parts << Search::Target.new(target[:search_target], target[:attribute]).like(escaped_word)
      end
      @base_query = @base_query.where(parts.join(' OR '))
    end
    @base_query
  end

  def escape_for_like(phrase)
    phrase.gsub("%", "\\%").gsub("_", "\\_")
  end
end
