# frozen_string_literal: true

module Report
  # Asserts that a component, as defined in the report YAML, contains only
  # valid-looking attributes. Raises an exception upon encountering an invalid
  # component.
  module ComponentValidator
    module_function

    # Contains all keys which may be assigned to a component.
    VALID_KEYS = (CONTENT_KEYS + %i(if children)).freeze

    MESSAGES = {
      too_much_content:
        'Component must not have multiple content attributes: %{component}',

      no_content:
        'Component must have some text or children: %{component}',

      unknown_keys:
        'Component must not have unknown attributes (%{keys}): %{component}'
    }.freeze

    # Given a component definition, asserts that it looks valid. Raises an error
    # if it isn't.
    def call(definition)
      content_keys = definition.keys & Report::CONTENT_KEYS

      error!(:too_much_content, definition) if content_keys.length > 1

      if content_keys.length.zero? && !definition.key?(:children)
        error!(:no_content, definition)
      end

      if (unknown_keys = definition.keys - VALID_KEYS).any?
        error!(:unknown_keys, definition, keys: unknown_keys)
      end

      true
    end

    # Presents a component definition in a slightly more readable way than
    # simply inspecting the hash.
    def present_component(definition)
      attrs = definition.keys.sort.map do |key|
        "#{ key }: #{ definition[key].inspect }"
      end.join(', ')

      "{ #{ attrs } }"
    end

    # Raises an error with the chosen message.
    def error!(key, definition, attrs = {})
      raise(MESSAGES.fetch(key) % {
        component: present_component(definition)
      }.merge(attrs))
    end
  end
end
