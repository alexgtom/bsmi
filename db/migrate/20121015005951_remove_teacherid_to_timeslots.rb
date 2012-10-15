class RemoveTeacheridToTimeslots < ActiveRecord::Migration
  def up
    remove_column :timeslots, :teacher_id
  end

  def down
    add_column :timeslots, :teacher_id, :integer
  end
end
