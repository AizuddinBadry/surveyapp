class SurveySession < ApplicationRecord
  belongs_to :user
  belongs_to :survey
  belongs_to :question
end
