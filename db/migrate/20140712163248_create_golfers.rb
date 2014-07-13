class CreateGolfers < ActiveRecord::Migration
  def change
    create_table :golfers do |t|
      t.string :name
      t.text :profile_url
      t.integer :rank

      t.timestamps
    end
  end
end
