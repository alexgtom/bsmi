class AddOwnerTypeToInvites < ActiveRecord::Migration
  def change
    add_column :invites, :owner_type, :string
  end
end
