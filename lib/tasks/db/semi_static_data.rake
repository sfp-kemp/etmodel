namespace :db do
  namespace :semi_static_data do
    desc 'exports current "semi-static models" to YAML'
    task export: :environment do
      semistatic_models = [ Constraint, Description, InputElement,
                            OutputElement, SidebarItem, Slide,
                            Tab, Text, OutputElementSerie,
                            OutputElementType, AreaDependency ]

      model_writer = ->(model) do
        filename = "config/semi_static_data/#{model.name
                                                   .underscore
                                                   .pluralize}.yml"
        data = model.all.map(&:attributes)
        File.open(filename, "w"){ |file| file.write data.to_yaml }
      end
      semistatic_models.each(&model_writer)
    end
  end
end
