# frozen_string_literal: true

# Contains features used to generate scenario reports and summaries.
module Report
  module_function

  # Components may contain one of these keys to define the content of the
  # component.
  CONTENT_KEYS = %i(h1 h2 h3 h4 h5 h6 text chart).freeze

  # Contains all keys which may be assigned to a component.
  VALID_KEYS = (CONTENT_KEYS + %i(if children)).freeze

  def build(report)
    build_components(report)
  end

  # Internal: Given an array of component definitions, converts each one
  # recusrively into a Component.
  #
  # Returns an array of Report::Component objects.
  def build_components(definitions)
    Array(definitions).map { |child| build_component(child.symbolize_keys) }
  end

  # Internal: Given a single component definition, creates a Component.
  #
  # Sets rules, and also converts all child components.
  #
  # Returns a Report::Component.
  def build_component(definition)
    ComponentValidator.call(definition)

    ruleset =
      if definition[:if]
        RuleSet.new([RuleParser.parse(definition[:if])])
      else
        RuleSet.new
      end

    Report::Component.new(
      extract_content(definition),
      ruleset,
      build_components(definition[:children])
    )
  end

  def extract_content(definition)
    if (attribute = CONTENT_KEYS.detect { |key| definition.key?(key) })
      return { type: attribute, content: definition[attribute] }
    end

    {} # No content; this is a container for other components.
  end
end
