# typed: strong

class AddCoordinationsToStories < ActiveRecord::Migration
  extend T::Sig

  sig { void }
  def change
    add_column :stories, :lat, :decimal, precision: 10, scale: 6
    add_column :stories, :lng, :decimal, precision: 10, scale: 6
  end
end
