# typed: strict

class MakeStoryBodyNotNull < ActiveRecord::Migration[6.0]
  extend T::Sig

  sig { void }
  def change
    change_column_null :stories, :body, false
  end
end
