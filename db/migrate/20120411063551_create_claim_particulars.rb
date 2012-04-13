class CreateClaimParticulars < ActiveRecord::Migration
  def self.up
    create_table :claim_particulars do |t|
      t.float :amount
      t.float :expeccted_amount
      t.string :given_by

      t.timestamps
    end
  end

  def self.down
    drop_table :claim_particulars
  end
end
