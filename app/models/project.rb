class Project < ApplicationRecord
  has_many :languages, foreign_key: :language_code
  accepts_nested_attributes_for :languages
  has_many :projecttypes, foreign_key: :protype_code
  has_many :statuses, foreign_key: :status_code
end
