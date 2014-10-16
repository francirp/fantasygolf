class ChangeRankToString < ActiveRecord::Migration
  def change
    change_column :competitors, :rank, :string
  end
end
