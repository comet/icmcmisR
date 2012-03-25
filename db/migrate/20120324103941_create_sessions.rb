class CreateSessions < ActiveRecord::Migration
  def self.up
    create_table :sessions do |t|
      t.integer :user_id
      t.integer :time_out
      t.string :login_ip
      t.string :login_status

      t.timestamps
    end
  end

  def self.down
    drop_table :sessions
  end
end
