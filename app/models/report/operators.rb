# frozen_string_literal: true
module Report
  Operators = {
    :<  => ->(a, b) { a < b },
    :<= => ->(a, b) { a <= b },
    :>  => ->(a, b) { a > b },
    :>= => ->(a, b) { a >= b },
    :== => ->(a, b) { a == b },
    :!= => ->(a, b) { a != b }
  }.freeze
end
