class AlterClientFriendship < ActiveRecord::Migration
  def up
  	rename_column("client_friendships", "client_one", "client_one_id")
  	rename_column("client_friendships", "client_two", "client_two_id")
  end

  def down
  	rename_column("client_friendships", "client_one_id", "client_one")
  	rename_column("client_friendships", "client_two_id", "client_two")
  end
end
