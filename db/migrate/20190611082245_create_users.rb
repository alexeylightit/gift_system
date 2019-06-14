class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.datetime :birth_date
      t.integer :loyalty, default: 0

      t.timestamps
    end
  end
end
