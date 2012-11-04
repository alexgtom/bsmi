class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.string :name
      t.string :email
      t.string :invite_code, :limit => 40
      t.datetime :invited_at
      t.datetime :redeemed_at
    end
    add_index :invites, [:id, :email]
    add_index :invites, [:id, :invite_code]
  end
end
