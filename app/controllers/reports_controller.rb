# frozen_string_literal: true

# Fetches and presents scenario reports and summaries.
class ReportsController < ApplicationController
  include MainInterfaceController.new(:show)

  before_action :ensure_scenario

  REPORT_DIR = Rails.root.join('config/reports')

  # Shows a scenario report.
  #
  # GET /scenario/reports/:id
  def show
    @components = Report::Presenter.new(
      Report.build(report_definition),
      Current.setting.api_session_id,
      I18n.locale
    )
  end

  private

  def ensure_scenario
    redirect_to('/') && return unless Current.setting.api_session_id
  end

  def report_path
    # The format of :id is tested by the router to assert only letters and
    # dashes may be present.
    REPORT_DIR.join("#{ params[:id].to_s.tr('-', '_') }.yml")
  end

  def report_definition
    unless report_path.file?
      throw ActiveRecord::NotFound, "No such report: #{ report_path.basename }"
    end

    YAML.load_file(report_path)
  end
end
