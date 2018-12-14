class AddForiegnToProject < ActiveRecord::Migration[5.2]
  def change
    execute 'ALTER TABLE project ADD CONSTRAINT fk_language_code FOREIGN KEY (language_code) REFERENCES language(language_code) ON DELETE RESTRICT;'
    execute 'ALTER TABLE project ADD CONSTRAINT fk_protype_code FOREIGN KEY (protype_code) REFERENCES projecttype(protype_code) ON DELETE RESTRICT;'
    execute 'ALTER TABLE project ADD CONSTRAINT fk_status_code FOREIGN KEY (status_code) REFERENCES status(status_code) ON DELETE RESTRICT;'
  end
end
