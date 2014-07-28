class AlterUsersAddLock < ActiveRecord::Migration
  def change
  	add_column("users", "lock", :boolean, :null => false, :default => true)
  end
end
