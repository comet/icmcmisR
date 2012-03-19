class AddFieldsToPerson < ActiveRecord::Migration
  def self.up
    add_column :people, :username, :string
    add_column :people, :password, :string
    add_column :people, :salt, :string
    add_column :people, :secret_question, :string
    add_column :people, :secret_answer, :string
  end

  def self.down
    remove_column :people, :secret_answer
    remove_column :people, :secret_question
    remove_column :people, :salt
    remove_column :people, :password
    remove_column :people, :username
  end
end
