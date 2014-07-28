class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
    	t.integer "production_id"
    	t.integer "user_id"
    	t.string "name", :null => false
    	t.datetime "when", :null => false
    	t.timestamps
    end
    add_index("events", "production_id")
    add_index("events", "user_id")
  end
end
