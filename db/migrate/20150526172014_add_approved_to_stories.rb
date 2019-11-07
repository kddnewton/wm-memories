# typed: strong

class AddApprovedToStories < ActiveRecord::Migration
  extend T::Sig

  sig { void }
  def change
    add_column :stories, :approved, :boolean, null: false, default: false
  end
end
