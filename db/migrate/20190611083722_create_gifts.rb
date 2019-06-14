class CreateGifts < ActiveRecord::Migration[5.2]
  def change
    create_table :gifts do |t|
      t.references :user, foreign_key: true
      t.string :type
      t.integer :amount
      t.string :reward

      t.timestamps
    end
  end
end
