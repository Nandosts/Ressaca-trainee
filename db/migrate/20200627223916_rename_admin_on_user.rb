class RenameAdminOnUser < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :admin?, :admin
  end
end
