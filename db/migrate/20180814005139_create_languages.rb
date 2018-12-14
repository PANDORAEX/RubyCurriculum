class CreateLanguages < ActiveRecord::Migration[5.2]
  def change
    create_table :language, id: false do |t|
      t.string :language_code, :limit => 2, :null => false
      t.string :language_name, :limit => 20, :null => false
    end
    execute "ALTER TABLE language ADD PRIMARY KEY (language_code);"
  end
end
