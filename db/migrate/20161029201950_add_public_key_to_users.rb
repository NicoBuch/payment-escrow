class AddPublicKeyToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :public_key, :string
  end
end
