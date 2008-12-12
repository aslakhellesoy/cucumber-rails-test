class CreateLorries < ActiveRecord::Migration
  def self.up
    create_table :lorries do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :lorries
  end
end
