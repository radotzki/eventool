class ChangeDateFormatForBirthdate < ActiveRecord::Migration
  def up
    change_column :clients, :birthdate, :datetime
  end

  def down
    change_column :clients, :birthdate, :date
  end
end
