class AddStatusToSemesters < ActiveRecord::Migration
  def change
    add_column :semesters, :status, :string
  end
end
