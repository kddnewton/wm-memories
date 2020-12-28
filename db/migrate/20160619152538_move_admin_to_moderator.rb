class MoveAdminToModerator < ActiveRecord::Migration[5.0]
  def change
    rename_table :admins, :moderators
  end
end
