class ChangeUserPasswordToHashedPassword < ActiveRecord::Migration
  def self.up
rename_column :people,:password,:hashed_password
  end

  def self.down
  end
end
