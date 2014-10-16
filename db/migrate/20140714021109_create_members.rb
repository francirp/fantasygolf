class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.integer :user_id
      t.integer :league_id
      t.string :role

      t.timestamps
    end
  end
end
