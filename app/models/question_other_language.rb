class QuestionOtherLanguage < ApplicationRecord
  belongs_to :survey_language
  belongs_to :question
end
