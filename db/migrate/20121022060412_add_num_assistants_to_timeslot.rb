class AddNumAssistantsToTimeslot < ActiveRecord::Migration
  def change
    add_column :timeslots, :num_assistants, :integer
  end
end
