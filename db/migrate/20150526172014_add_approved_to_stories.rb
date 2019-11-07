# typed: false
class AddApprovedToStories < ActiveRecord::Migration
  def change
    add_column :stories, :approved, :boolean, null: false, default: false
  end
end
