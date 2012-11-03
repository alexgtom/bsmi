class RenameNumAssistantsToMaxNumAssistants < ActiveRecord::Migration
  def up
    rename_column :timeslots, :num_assistants, :max_num_assistants
  end

  def down
  end
end
