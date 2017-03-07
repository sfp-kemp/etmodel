# frozen_string_literal: true
module Report
  # Presents a Report as JSON for consumption by the browser.
  #
  # Fetches data as necessary from ETEngine to determine which components should
  # be shown, and returns the results as JSON.
  class Presenter
    # Components may contain one of these keys to define the content of the
    # component.
    CONTENT_KEYS = %i(h1 h2 h3 h4 h5 h6 text chart).freeze

    def initialize(components, scenario_id, locale)
      @components  = components
      @scenario_id = scenario_id
      @locale      = locale
    end

    def as_json(*)
      { components: components_json(@components) }
    end

    private

    # Internal: Given an array of components, converts each to a plain hash
    # suitable for serialization as JSON.
    #
    # components - The components to be presented.
    #
    # Returns an array of hashes.
    def components_json(components)
      Array(components).map do |component|
        component.show?(query_data) ? component_json(component) : nil
      end.compact
    end

    # Internal: Converts a single component to a plain hash.
    #
    # component - The component to be presented.
    #
    # Returns a hash.
    def component_json(component)
      component.content.except(*CONTENT_KEYS).merge(
        component_content(component.content)
      ).merge(
        children: components_json(Array(component.children))
      )
    end

    # Internal: Converts component content to be suitable for consumption as
    # JSON.
    #
    # Returns a hash.
    def component_content(content)
      CONTENT_KEYS.each do |attribute|
        next unless content.key?(attribute)

        new_attrs = { type: attribute, content: content[attribute] }

        if new_attrs[:content].is_a?(Hash)
          new_attrs[:content] = new_attrs[:content][@locale.to_s]
        end

        return new_attrs
      end

      {} # No content; this is a container for other components.
    end

    # Internal: Fetches and returns query data from ETEngine for use in
    # determining which comonents should be presented.
    #
    # Returns a hash in the form:
    #   { query_key: { present: Numeric, future: Numeric, unit: String } }
    def query_data
      return @query_data if @query_data

      requirements = @components.flat_map(&:requirements)

      @query_data =
        if requirements.empty?
          {}
        else
          scenario = Api::Scenario.find_with_queries(@scenario_id, requirements)
          scenario['gqueries'].symbolize_keys.transform_values(&:symbolize_keys)
        end
    end
  end
end
