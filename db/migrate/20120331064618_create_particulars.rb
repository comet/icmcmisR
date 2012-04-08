class CreateParticulars < ActiveRecord::Migration
  def self.up
    create_table :particulars do |t|
      t.integer :payment_id
      t.integer :payable_id
      t.integer :user_id
      t.string :status

      t.timestamps
    end
  end

  def self.down
    drop_table :particulars
  end
end
