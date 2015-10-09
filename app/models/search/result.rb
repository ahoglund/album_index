class Search::Result 

  def self.build(&block)
  	result = new
  	result.instance_eval(&block)
  	result.results
  end

  attr_accessor :results

	def initialize
    @results = {}
	end

  def method_missing(method_name, *args, &block)
    @results[method_name] = args.join(" ")
  end
end
