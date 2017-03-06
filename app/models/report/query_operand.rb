# frozen_string_literal: true
module Report
  # Describes a dynamic value which is determined by requesting a query from
  # ETEngine.
  class QueryOperand
    def self.present(query)
      new(query, :present)
    end

    def self.future(query)
      new(query, :future)
    end

    def call(values)
      values.fetch(@query).fetch(@period)
    end

    def requirements
      [@query]
    end

    def to_s
      "#{ self.class.name.demodulize }.#{ @period }(#{ @query.inspect })"
    end

    private_class_method :new

    def initialize(query, period)
      @query = query
      @period = period
    end
  end
end
