class CreateAdvisors < ActiveRecord::Migration
  def change
    create_table :advisors do |t|

      t.timestamps
    end
  end
end
