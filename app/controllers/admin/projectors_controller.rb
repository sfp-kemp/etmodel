# frozen_string_literal: true

module Admin
  class ProjectorsController < BaseController
    def index; end

    def new
      @projector = Projector.new
      @sliders = InputElement.all
    end
  end
end
