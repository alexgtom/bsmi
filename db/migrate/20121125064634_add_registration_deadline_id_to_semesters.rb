class AddRegistrationDeadlineIdToSemesters < ActiveRecord::Migration
  def change
    add_column :semesters, :registration_deadline_id, :integer
  end
end
