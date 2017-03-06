# frozen_string_literal: true
module Report
  class LiteralOperand
    def initialize(value)
      @value = value
    end

    def call(_values)
      @value
    end

    def requirements
      []
    end

    def to_s
      "#{ self.class.name.demodulize }(#{ @value })"
    end
  end
end
