class CreateTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :transactions do |t|
      t.belongs_to :address, foreign_key: true
      t.integer :satoshis

      t.timestamps
    end
  end
end
