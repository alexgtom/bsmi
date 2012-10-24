class AddOwnerToUser < ActiveRecord::Migration
  def change
    change_table(:users) do |t|
      t.references :owner, :polymorphic => true
    end
  end
end
