class CreateProductions < ActiveRecord::Migration
  def change
    create_table :productions do |t|
    	t.string "name", :null => false
    	t.timestamps
    end
  end
end
