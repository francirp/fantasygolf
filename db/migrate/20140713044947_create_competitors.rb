class CreateCompetitors < ActiveRecord::Migration
  def change
    create_table :competitors do |t|
      t.integer :golfer_id
      t.integer :tournament_id
      t.integer :rank
      t.float :earnings

      t.timestamps
    end
  end
end
