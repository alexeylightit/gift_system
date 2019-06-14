class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.references :user, foreign_key: true
      t.monetize :amount
      t.boolean :is_foreign

      t.timestamps
    end
  end
end
