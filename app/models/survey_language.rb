class SurveyLanguage < ApplicationRecord
  belongs_to :survey
  has_many :questions, dependent: :delete_all
end
