class CreateTests < ActiveRecord::Migration
  def self.up
    create_table :tests do |t|
      t.string :name
      t.string :description
      t.integer :specific_id

      t.timestamps
    end
  end

  def self.down
    drop_table :tests
  end
end
