class AddKeyToTransaction < ActiveRecord::Migration[5.0]
  def change
    add_column :transactions, :key, :string
  end
end
