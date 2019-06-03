class CreateSpendReasons < ActiveRecord::Migration[5.1]
  def change
    create_table :spend_reasons do |t|
      t.string :name

      t.timestamps
    end
  end
end
