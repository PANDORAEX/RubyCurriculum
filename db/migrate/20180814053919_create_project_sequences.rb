class CreateProjectSequences < ActiveRecord::Migration[5.2]
  def change
    create_table :project_sequences, id: false do |t|
      t.string :name
      t.integer :number
    end
    execute "ALTER TABLE project_sequences ADD PRIMARY KEY (name);"
  end
end
