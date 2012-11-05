class AddForeignKeyToTimeslots < ActiveRecord::Migration
  def change
    add_column :timeslots, :course_id, :integer
  end
end
