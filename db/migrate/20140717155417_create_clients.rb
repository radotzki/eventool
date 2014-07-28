class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
    	t.integer "production_id"
    	t.string "first_name", :null => false
    	t.string "last_name", :null => false
    	t.string "phone_number"
    	t.date "birthdate"
    	t.string "city"
    	t.integer "gender", :null => false, :default => 0
    	t.timestamps
    end
    add_index("clients", "production_id")
  end
end
