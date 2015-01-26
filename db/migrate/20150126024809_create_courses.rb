class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :sports_data_api_id
      t.string :name
      t.integer :yardage
      t.integer :par
      t.hstore :holes

      t.timestamps
    end
  end
end
