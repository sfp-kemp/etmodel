# frozen_string_literal: true
module Report
  # Combines two or more operands and a comparison operation to determine if the
  # rule passes, and the component should be shown.
  class Rule
    # Internal: Returns the operands used by the Rule
    attr_reader :operands

    def initialize(operands, operator)
      @operands = operands
      @operator = operator
    end

    def call(values)
      @operator.call(*@operands.map { |op| op.call(values) })
    end

    def requirements
      operands.flat_map { |operand| operand.try(:requirements) }
    end

    def to_s
      join_with = Operators.invert[@operator] || @operator.class.name.demodulize
      "Rule(#{ @operands.map(&:to_s).join(" #{ join_with } ") })"
    end
  end
end
