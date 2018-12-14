class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :project, id: false do |t|
      t.decimal :project_id, precision: 4, scale: 0, :null => false
      t.date :start_date, :null => false
      t.string :project_no, :limit => 15, :null => false
      t.string :project_name, :limit => 30, :null => false
      t.string :protype_code, :limit => 2, :null => false, foreign_key: { to_table: :projecttype }
      t.string :language_code, :limit => 2, :null => false, foreign_key: { to_table: :language }
      t.string :summary, :limit => 255, :null => false
      t.string :status_code, :limit => 1, :null => false, foreign_key: { to_table: :status }
      t.string :customer, :limit => 20
      t.string :charge, :limit => 20
      t.string :reviewer, :limit => 20
      t.date :release
      t.string :remarks, :limit => 255
    end
    execute "ALTER TABLE project ADD PRIMARY KEY (project_id);"
  end
end
