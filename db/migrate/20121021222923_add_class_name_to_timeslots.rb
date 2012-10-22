class AddClassNameToTimeslots < ActiveRecord::Migration
  def change
    add_column :timeslots, :class_name, :string
  end
end
