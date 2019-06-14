class CreatePoints < ActiveRecord::Migration[5.2]
  def change
    create_table :points do |t|
      t.references :user, foreign_key: true
      t.integer :reason_id
      t.string :reason_type
      t.float :amount
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :points, :deleted_at
    add_index :points, [:reason_type, :reason_id]
  end
end
