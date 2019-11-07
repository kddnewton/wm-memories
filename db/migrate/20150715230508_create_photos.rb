# typed: true
class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.references :story
      t.has_attached_file :attachment
      t.timestamps
    end
  end
end
