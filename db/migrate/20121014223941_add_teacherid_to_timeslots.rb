class AddTeacheridToTimeslots < ActiveRecord::Migration
  def change
    add_column :timeslots, :teacher_id, :integer
  end
end
