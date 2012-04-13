class CreateFamilies < ActiveRecord::Migration
  def self.up
    create_table :families do |t|
      t.string :name
      t.string :description
      t.float :maximum_cover
      t.float :minimum_cover

      t.timestamps
    end
  end

  def self.down
    drop_table :families
  end
end
