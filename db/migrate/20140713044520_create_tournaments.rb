class CreateTournaments < ActiveRecord::Migration
  def change
    create_table :tournaments do |t|
      t.string :name
      t.date :start_date
      t.text :url

      t.timestamps
    end
  end
end
