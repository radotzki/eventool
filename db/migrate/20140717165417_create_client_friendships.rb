class CreateClientFriendships < ActiveRecord::Migration
  def change
    create_table :client_friendships do |t|
    	t.integer "user_id"
    	t.timestamps
    end   
    add_column :client_friendships, :client_one, :integer
    add_column :client_friendships, :client_two, :integer
    add_index("client_friendships", "client_one")
    add_index("client_friendships", "client_two")
    add_index("client_friendships", "user_id")
  end
end

