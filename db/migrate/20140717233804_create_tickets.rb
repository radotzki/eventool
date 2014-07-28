class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
    	t.integer "client_id"
    	t.integer "event_id"
    	t.integer "event_price_id"
    	t.integer "promoter_id"
    	t.integer "cashier_id"
    	t.boolean "arrived"
    	t.string "reason"
    	t.timestamps
    end    
    add_index("tickets", "client_id")
    add_index("tickets", "promoter_id")
    add_index("tickets", "cashier_id")
    add_index("tickets", "event_id")
    add_index("tickets", "event_price_id")
  end
end
