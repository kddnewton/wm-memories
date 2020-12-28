class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.string :email, null: false
      t.boolean :validated, default: false, null: false
      t.timestamps
    end
  end
end
