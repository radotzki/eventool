class AlterUserAddRoleEnum < ActiveRecord::Migration
  def change
  	add_column("users", "role", :integer, :default => 2, :null => false)
  end
end
