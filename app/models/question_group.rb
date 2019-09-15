class QuestionGroup < ApplicationRecord
  validates_presence_of :name
  belongs_to :survey
end
