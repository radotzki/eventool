class CreateEventPrices < ActiveRecord::Migration
  def change
    create_table :event_prices do |t|
    	t.integer "event_id"
    	t.integer "price"
    end
    add_index("event_prices", "event_id")
  end
end
