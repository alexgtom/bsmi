class AddDistrictIdToSchools < ActiveRecord::Migration
  def change
    add_column :schools, :district_id, :string
  end
end
