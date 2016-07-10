class AddInvitedByToUser < ActiveRecord::Migration
  def change
    add_reference :users, :invited_by, references: :users, index: true
    add_foreign_key :users, :users, column: :invited_by_id
  end
end
