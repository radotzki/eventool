class DeleteUserType < ActiveRecord::Migration
  def up
  	drop_table :user_types
  end
  def down
	create_table :user_types do |t|
		t.string "name", :null => false
	end
  end
end
