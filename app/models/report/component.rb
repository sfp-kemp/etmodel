# frozen_string_literal: true
module Report
  # Represents a block-level element in a report. May have rules which determine
  # whether to show the component based on the values in the scenario.
  class Component
    attr_reader :content, :children, :ruleset

    def initialize(content, ruleset = RuleSet.new, children = [])
      @content  = content
      @ruleset  = ruleset
      @children = Array(children).freeze
    end

    def requirements
      (Array(@ruleset.try(:requirements)) +
        Array(@children.flat_map(&:requirements))
      ).uniq
    end

    def show?(values)
      @ruleset.call(values)
    end
  end
end
