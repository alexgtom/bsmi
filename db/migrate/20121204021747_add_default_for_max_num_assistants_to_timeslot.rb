class AddDefaultForMaxNumAssistantsToTimeslot < ActiveRecord::Migration
  def change
    change_column(:timeslots, :max_num_assistants, :integer, :default => 1)
  end
end
