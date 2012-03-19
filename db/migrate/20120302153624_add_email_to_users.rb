class AddEmailToUsers < ActiveRecord::Migration
  def change
    add_column :email, :string
  end
end
