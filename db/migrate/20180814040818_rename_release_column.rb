class RenameReleaseColumn < ActiveRecord::Migration[5.2]
  def self.up
    rename_column :projects, :release, :release_date
  end
  def self.down
    rename_column :projects, :release_date, :release
  end
end
