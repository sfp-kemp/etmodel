class AddSaveToResults < ActiveRecord::Migration[5.2]
  def up
    tab = Tab.find_by key: "data"

    sidebar_item = SidebarItem.create! key: "save",
                                       tab: tab,
                                       position: 4

    slide = Slide.create! sidebar_item: sidebar_item,
                          key: "data_file_save",
                          position: 6,
                          output_element_id: 241

    Description.create! content_en: save_result_html('This is the english text edit','Save Scenario', 'Save Scenario As'),
                        describable: slide,
                        content_nl: save_result_html(*nl_html_opts)
  end

  def down
    SidebarItem.find_by(key: "save").destroy
    slide = Slide.find_by(key: "data_file_save")
    slide.description.destroy
    slide.destroy
  end

  private

  def nl_html_opts
    ['Wanneer je op een later moment wilt terugkeren naar dit scenario of deze wilt delen kan je deze hier opslaan.',
     'Scenario Opslaan',
     'Scenario opslaan als']
  end

  def en_html_opts
    ['You can return to or share the scenario at a later time by saving it using the button below.',
     'Save Scenario',
     'Save Scenario As']
  end

  def save_result_html(body, save_link_text, save_as_link_text)
    "<p>#{body}</p>" +
    '<a id="save-from-slide" class="button--wide button--disabled" ' +
        'data-remote="true" rel="nofollow" data-method="put" ' +
        'href="/scenarios/{{scenario_id}}">' +
        save_link_text +
    '</a>' +
    '<a id="save-as-from-slide" class="button--wide" ' +
        'href="/scenarios/new">' +
        save_as_link_text +
    '</a>' +
    '<script> updateSaveFromSlide() </script>'
  end
end
