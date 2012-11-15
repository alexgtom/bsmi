class ChangeDistrictIdFormatInSchools < ActiveRecord::Migration
  def up
    change_column :schools, :district_id, :integer
  end

  def down
    change_column :schools, :district_id, :string
  end
end
