class ChangeKeyNameInTransactions < ActiveRecord::Migration[5.0]
  def change
    change_column :transactions, :key, :text
    rename_column :transactions, :key, :serialization
  end
end
