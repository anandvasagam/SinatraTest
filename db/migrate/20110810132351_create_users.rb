class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :username
      t.string :displayname
      t.string :headendID
    end
  end

  def self.down
    drop_table :users
  end
end
