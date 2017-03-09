module Report
  # Takes a rule string and produces a functional Rule for use in a RuleSet.
  class RuleParser
    def self.parse(rule_str)
      new(rule_str).to_rule
    end

    private_class_method :new

    # Internal: Parses a rule string into a working Rule.
    #
    # For example
    #   parse_rule_string('future(total_co2_emissions) > 1000')
    #   # => Report::Rule
    #
    # Returns a Rule or Rule-compatible object which responds to 'call'.
    def to_rule
      # User may set a rule to true or false explicity while building a report.
      if @rule_str == true || @rule_str == false
        return LiteralOperand.new(@rule_str)
      end

      # Parse in order for more useful error messages (i.e. don't warn about a
      # missing right operand if the operator is also missing).
      left  = parse_operand(:left)
      op    = operator
      right = parse_operand(:right)

      validate_rest

      Rule.new([left, right], op)
    end

    private

    def initialize(rule_str)
      @rule_str = rule_str
    end

    def tokens
      @tokens ||= String(@rule_str).strip.split(' ')
    end

    # Internal: Parses a single operand in a rule into something which may be
    # used as an operand in a Rule.
    #
    # Returns an object which reponds to 'call'. Raises an error if the operand
    # couldn't be parsed.
    def parse_operand(name)
      value = tokens[name == :left ? 0 : 2]
      raise(error("Missing #{ name } operand")) unless value

      if (match = value.match(/(?<period>present|future)\((?<query>[^)]+)\)/))
        # Matches a future(...) or present(...) call within a rule string.
        QueryOperand.public_send(match[:period], match[:query].to_sym)
      else
        case value
        when /\d+(?:\.\d+)?/ then LiteralOperand.new(Float(value))
        when 'true'          then LiteralOperand.new(true)
        when 'false'         then LiteralOperand.new(false)
        else
          raise(error("Unparseable operand #{ value }"))
        end
      end
    end

    # Internal: Looks up the operator from the rule and returns a callable
    # operator object.
    def operator
      raise(error('Missing operator')) unless tokens[1]

      Operators[String(tokens[1]).to_sym] ||
        raise(error("Unknown operator #{ tokens[1] }"))
    end

    # Internal: Formats an exception error message to provide some context.
    def error(message)
      "#{ message } in: #{ @rule_str }"
    end

    # Internal: Assert that there are no unused tokens in the rule.
    def validate_rest
      rest = tokens[3..-1]
      raise(error("Unused rule tokens #{ rest }")) if rest && rest.any?
    end
  end
end
