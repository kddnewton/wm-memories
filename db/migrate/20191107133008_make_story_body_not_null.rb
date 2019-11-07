# typed: true
class MakeStoryBodyNotNull < ActiveRecord::Migration[6.0]
  def change
    change_column_null :stories, :body, false
  end
end
