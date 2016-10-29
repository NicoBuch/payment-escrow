class RenameAdminColumnFromUsers < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :admin, :mediator
  end
end
