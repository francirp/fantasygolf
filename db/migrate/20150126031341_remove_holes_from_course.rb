class RemoveHolesFromCourse < ActiveRecord::Migration
  def change
    remove_column :courses, :holes
  end
end
