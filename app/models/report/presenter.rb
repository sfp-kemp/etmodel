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

    # Default scenario fetcher. Override in tests by giving a custom 'fetcher'
    # argument when initializing.
    FETCH_SCENARIO = lambda do |scenario_id, queries|
      Api::Scenario.find_with_queries(scenario_id, queries)
    end

    def initialize(components, scenario_id, locale, fetcher: nil)
      @components  = components
      @scenario_id = scenario_id
      @locale      = locale
      @fetcher     = fetcher || FETCH_SCENARIO
      @errors      = []
    end

    def as_json(*)
      # Eager fetch results so that we can skip creating components if there was
      # an ETE error.
      query_data

      if @errors.any?
        { errors: @errors, components: [] }
      else
        { components: components_json(@components) }
      end
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
      component.content.merge(
        content: component_content(component.content),
        children: components_json(Array(component.children))
      ).compact
    end

    # Internal: Converts component content to be suitable for consumption as
    # JSON.
    #
    # Returns a hash.
    def component_content(content)
      if content[:content].is_a?(Hash)
        content[:content][@locale.to_s]
      else
        content[:content]
      end
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
          data_from_response(@fetcher.call(@scenario_id, requirements))
        end
    end

    # Internal: Extracts query data from a response.
    #
    # Adds errors to @errors if the response was unsuccessful, and returns an
    # empty hash.
    #
    # Returns the query data.
    def data_from_response(response)
      if response['errors']
        @errors.push(*response['errors'])
        return {}
      end

      response['gqueries'].symbolize_keys.transform_values(&:symbolize_keys)
    end
  end
end
