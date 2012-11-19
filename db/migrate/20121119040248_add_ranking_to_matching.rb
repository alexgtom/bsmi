class AddRankingToMatching < ActiveRecord::Migration
  def change
    add_column :matchings, :ranking, :integer
  end
end
