class AddCoordinationsToStories < ActiveRecord::Migration
  def change
    add_column :stories, :lat, :decimal, precision: 10, scale: 6
    add_column :stories, :lng, :decimal, precision: 10, scale: 6
  end
end
