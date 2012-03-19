class AddAdminRowToUser < ActiveRecord::Migration
  def self.up
    execute "insert into people (type,username, surname, first_name,hashed_password,salt) values ('User','admin', 'admin', 'admin','d1ff9e05b25bf4eccf595cdd204df93f20c2d419','DsnhwhnJeM')"
  end

  def self.down
  end
end
