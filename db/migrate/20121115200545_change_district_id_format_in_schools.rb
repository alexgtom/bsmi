class ChangeDistrictIdFormatInSchools < ActiveRecord::Migration
  def up
    remove_column :schools, :district_id
    add_column :schools, :district_id, :integer
  end

  def down
    remove_column :schools, :district_id
    add_column :schools, :district_id, :string
  end
end
