# frozen_string_literal: true
module Report
  # Takes zero or more rules and determines if they pass.
  class RuleSet
    # Public: Creates a new RuleSet.
    #
    # rules     - An array of zero or more Rule instances
    # match_all - True will require all rules to pass in order for the rule set
    #             to return true. Otherwise the rule set will be truthy if any
    #             one or more rules pass.
    #
    def initialize(rules = [], match_all = true)
      @rules = rules
      @match_all = match_all
    end

    def call(values)
      @rules.public_send(@match_all ? :all? : :any?) do |rule|
        rule.call(values)
      end
    end

    def requirements
      @rules.flat_map { |rule| rule.try(:requirements) }.uniq
    end

    def to_s
      @rules.map(&:to_s).join(@match_all ? ' && ' : ' || ')
    end
  end
end
