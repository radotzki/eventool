class AlterTicketDefaultArrived < ActiveRecord::Migration
  def up
  	change_column("tickets", "arrived", :boolean, :default => false, :null => false)
  end

  def down
  	change_column("tickets", "arrived", :boolean)
  end
end
