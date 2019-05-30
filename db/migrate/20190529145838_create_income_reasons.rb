class CreateIncomeReasons < ActiveRecord::Migration[5.1]
  def change
    create_table :income_reasons do |t|
      t.string :name

      t.timestamps
    end
  end
end
