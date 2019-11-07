# typed: strict

class CreatePhotos < ActiveRecord::Migration
  extend T::Sig

  sig { void }
  def change
    create_table :photos do |t|
      t.references :story
      t.has_attached_file :attachment
      t.timestamps
    end
  end
end
