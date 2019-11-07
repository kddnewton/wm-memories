# typed: strict

class MoveAdminToModerator < ActiveRecord::Migration[5.0]
  extend T::Sig

  sig { void }
  def change
    rename_table :admins, :moderators
  end
end
