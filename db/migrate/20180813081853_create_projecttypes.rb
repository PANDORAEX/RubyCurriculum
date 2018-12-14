class CreateProjecttypes < ActiveRecord::Migration[5.2]
  def change
    create_table :projecttype, id: false do |t|
      t.string :protype_code, :limit => 2, :null => false
      t.string :protype_name, :limit => 20, :null => false
    end
    execute "ALTER TABLE projecttype ADD PRIMARY KEY (protype_code);"
  end
end
