class CreateSpendBudgets < ActiveRecord::Migration[5.1]
  def change
    create_table :spend_budgets do |t|
      t.date :target_date
      t.integer :amount
      t.text :memo
      t.references :spend_reason, foreign_key: true
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
