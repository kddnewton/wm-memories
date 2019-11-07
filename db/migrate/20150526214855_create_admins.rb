# typed: strict

class CreateAdmins < ActiveRecord::Migration
  extend T::Sig

  sig { void }
  def change
    create_table :admins do |t|
      t.string :email, null: false
      t.timestamps
    end
  end
end
