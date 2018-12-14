class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users, id: false do |t|
      t.string :userid, :limit => 8, :null => false
      t.string :password, :null => false, :limit => 50
    end
    execute "ALTER TABLE users ADD PRIMARY KEY (userid);"
  end
end
