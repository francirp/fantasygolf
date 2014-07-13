class ChangeCbsIdToProfileId < ActiveRecord::Migration
  def change
    rename_column :golfers, :cbs_id, :profile_id
  end
end
