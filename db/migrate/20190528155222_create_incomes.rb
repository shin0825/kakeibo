class CreateIncomes < ActiveRecord::Migration[5.1]
  def change
    create_table :incomes do |t|
      t.integer :amount
      t.references :wallet, foreign_key: true
      t.references :income_reason, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
