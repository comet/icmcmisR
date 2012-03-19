class CreatePeople < ActiveRecord::Migration
  def self.up
    create_table :people do |t|
      t.string :first_name
      t.string :given_name
      t.string :surname
      t.string :gender
      t.string :address
      t.string :phone_number
      t.string :alt_phone_number
      t.datetime :birth_date
      t.string :birth_date_estimate
      t.integer :alive
      t.integer :created_by
      t.integer :personifiable_id

      t.timestamps
    end
  end

  def self.down
    drop_table :people
  end
end
