class CreateDeadlines < ActiveRecord::Migration
  def change
    create_table :deadlines do |t|
      t.string :title
      t.text :summary
      t.datetime :due_date

      t.timestamps
    end
  end
end
