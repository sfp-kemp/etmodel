# frozen_string_literal: true

class Projector < ActiveRecord::Base
  serialize :sliders, Array
end
