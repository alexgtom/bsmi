class RemoveClassNameFromTimeslots < ActiveRecord::Migration
  def up
    remove_column :timeslots, :class_name
  end

  def down
    add_column :timeslots, :class_name, :string
  end
end
