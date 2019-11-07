# typed: strict

class CreateStories < ActiveRecord::Migration
  extend T::Sig

  sig { void }
  def change
    create_table :stories do |t|
      t.integer :year
      t.text :body
      t.timestamps
    end
  end
end
