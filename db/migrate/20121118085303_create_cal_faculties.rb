class CreateCalFaculties < ActiveRecord::Migration
  def change
    create_table :cal_faculties do |t|

      t.timestamps
    end
  end
end
