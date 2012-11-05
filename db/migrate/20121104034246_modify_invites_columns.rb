class ModifyInvitesColumns < ActiveRecord::Migration
  def change
    remove_column :invites, :name
    add_column :invites, :first_name, :string
    add_column :invites, :last_name, :string
  end
end
