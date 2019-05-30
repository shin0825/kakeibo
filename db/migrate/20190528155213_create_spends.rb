class CreateSpends < ActiveRecord::Migration[5.1]
  def change
    create_table :spends do |t|
      t.integer :amount
      t.references :wallet, foreign_key: true
      t.references :spend_reason, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
