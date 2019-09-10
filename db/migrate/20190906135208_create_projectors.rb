# frozen_string_literal: true

class CreateProjectors < ActiveRecord::Migration[5.2]
  def change
    create_table :projectors do |t|
      t.string :name
      t.string :description
      t.string :sliders, default: [].to_yaml

      t.timestamps
    end
  end
end
