class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table "users" do |t|
      t.string  "fullname"
      t.string  "username"
      t.string  "hashed_password"
      t.string  "salt"
      t.string  "email"
    end
  end

  def self.down
    drop_table "users"
  end
end
