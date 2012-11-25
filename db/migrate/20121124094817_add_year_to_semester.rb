class AddYearToSemester < ActiveRecord::Migration
  def change
    add_column :semesters, :year, :integer
  end
end
