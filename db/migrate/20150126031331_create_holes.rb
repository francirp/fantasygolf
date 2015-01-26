class CreateHoles < ActiveRecord::Migration
  def change
    create_table :holes do |t|
      t.references :course, index: true
      t.integer :number
      t.integer :par
      t.integer :yardage

      t.timestamps
    end
  end
end
