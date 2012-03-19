class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.integer :person_id
      t.string :username
      t.string :password
      t.string :salt
      t.string :secret_question
      t.string :secret_answer
      t.integer :creator_id

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
