class Language < ApplicationRecord
  belongs_to :projects, :foreign_key => "language_code"
end
