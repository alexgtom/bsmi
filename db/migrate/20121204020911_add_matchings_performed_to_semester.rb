class AddMatchingsPerformedToSemester < ActiveRecord::Migration
  def change
    add_column :semesters, :matchings_performed, :boolean, :default => false
  end
end
