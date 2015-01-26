class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.string :sports_data_api_id
      t.string :name
      t.string :city
      t.string :state
      t.string :zipcode
      t.string :country

      t.timestamps
    end
  end
end
