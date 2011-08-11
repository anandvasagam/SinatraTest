class CreateSections < ActiveRecord::Migration
  def self.up
    begin
    create_table :sections do |t|
      t.string :userId
      t.string :title
      t.string :shows
      t.string :actors
    end
    rescue
      true
    end
  end

  def self.down
    begin
    drop_table :sections
    rescue
      true
    end
  end
end
