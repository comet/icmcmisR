class CreateSettlements < ActiveRecord::Migration
  def self.up
    create_table :settlements do |t|
      t.float :amount
      t.float :expected_amount
      t.string :given_by

      t.timestamps
    end
  end

  def self.down
    drop_table :settlements
  end
end
