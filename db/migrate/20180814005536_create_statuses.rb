class CreateStatuses < ActiveRecord::Migration[5.2]
  def change
    create_table :status, id: false do |t|
      t.string :status_code, :limit => 2, :null => false
      t.string :status_name, :limit => 20, :null => false
    end
    execute "ALTER TABLE status ADD PRIMARY KEY (status_code);"
  end
end
