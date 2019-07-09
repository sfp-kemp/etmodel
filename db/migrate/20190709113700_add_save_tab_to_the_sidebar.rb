class AddSaveTabToTheSidebar < ActiveRecord::Migration[5.2]
  def up
    ActiveRecord::Base.transaction do
      tab = Tab.create! key: "save_scenario",
                        position:100

      sidebar_item = SidebarItem.create! key: "file",
                                         tab: tab,
                                         position: 0

      slide = Slide.create! sidebar_item: sidebar_item,
                            key: "file_save",
                            position: 0,
                            output_element_id: 241

      Description.create! id: 1465,
                          content_en: "<p> This is the english text edit </p>\r\n\r\n<a id=\"save-from-slide\" class=\"button button--disabled\" href=\"/scenarios/{{scenario_id}}\" >\r\n  Save Scenario\r\n</a>\r\n\r\n<a id=\"save-as-from-slide\" class=\"button\" href=\"/scenarios/new\">\r\n  Save Scenario As\r\n</a>",
                          describable: slide,
                          content_nl: "<p> Dit is de nederlandse text</p>\r\n\r\n<a id=\"save-from-slide\" class=\"button button--disabled\"  href=\"/scenarios/{{scenario_id}}\" >\r\n  Scenario Opslaan\r\n</a>\r\n\r\n<a id=\"save-as-from-slide\" class=\"button\" href=\"/scenarios/new\">\r\n  Scenario Opslaan Als\r\n</a>"
    end
  end

  def down
    ActiveRecord::Base.transaction do
      Tab.find_by(key: "save_scenario").destroy
      SidebarItem.find_by(key: "file").destroy
      slide = Slide.find_by(key: "file_save")
      slide.description.destroy
      slide.destroy
    end
  end
end
