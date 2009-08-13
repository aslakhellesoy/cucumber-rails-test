class AddColourToLorries < ActiveRecord::Migration
  def self.up
    add_column :lorries, :colour, :string
  end

  def self.down
    remove_column :lorries, :colour
  end
end
