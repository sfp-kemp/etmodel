require 'spec_helper'

describe "loading a preset scenario", :js => true, :vcr => true do
  fixtures :tabs, :sidebar_items, :slides, :output_elements, :output_element_types

  pending "should create a new scenario from a preset" do
    visit home_path
    # save_and_open_page
    click_link "Start an existing scenario"
    click_link "Referentiescenario 2030 gebaseerd op ..."

    page.should have_content('Household energy demand')

    settings = page.evaluate_script('App.settings.toJSON()')

    settings['area_code'].should == 'nl'
    settings['end_year'].should == 2030
    settings['preset_scenario_id'].should == 1

    new_scenario_id = settings['api_session_id']
    remote_scenario = Api::Scenario.find new_scenario_id

    remote_scenario.template.should == 1
    remote_scenario.end_year.should == 2030
    remote_scenario.area_code.should == 'nl'
  end
end