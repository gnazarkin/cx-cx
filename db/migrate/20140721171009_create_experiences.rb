class CreateExperiences < ActiveRecord::Migration
  def change
    create_table :experiences do |t|
      t.string :name
      t.text :description
      t.integer :price
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
