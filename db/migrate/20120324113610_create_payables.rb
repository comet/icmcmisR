class CreatePayables < ActiveRecord::Migration
  def self.up
    create_table :payables do |t|
      t.string :name
      t.text :description
      t.string :type
      t.integer :encounter_id
      t.integer :duration
      t.float :price
      t.text :other_info
      t.string :category

      t.timestamps
    end
  end

  def self.down
    drop_table :payables
  end
end
