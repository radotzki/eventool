class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
    	t.integer "production_id"
    	t.integer "user_types_id"
    	t.string "username", :null => false
    	t.string "password", :null => false
    	t.string "email"
    	t.string "first_name", :null => false
    	t.string "last_name", :null => false
    	t.string "phone_number"
    	t.timestamps
    end
    add_index("users", "production_id")
    add_index("users", "user_types_id")
  end
end
