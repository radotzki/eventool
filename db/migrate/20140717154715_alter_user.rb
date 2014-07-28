class AlterUser < ActiveRecord::Migration
  def up
  	rename_column("users", "user_types_id", "user_type_id")
  end

  def down
  	rename_column("users", "user_type_id", "user_types_id")
  end
end
