class AddCbsIdToGolfer < ActiveRecord::Migration
  def change
    add_column :golfers, :cbs_id, :string
    remove_column :golfers, :profile_url
  end
end
