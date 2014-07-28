class CreateClientComments < ActiveRecord::Migration
  def change
    create_table :client_comments do |t|
    	t.integer "user_id"
    	t.integer "client_id"
    	t.text "comment"
    	t.timestamps
    end
    add_index("client_comments", "user_id")
    add_index("client_comments", "client_id")
  end
end
