class Survey < ApplicationRecord
  validates_presence_of :title

  belongs_to :user
  has_many :question_groups, dependent: :destroy
  has_many :questions, class_name: 'Question', foreign_key: 'survey_id'
end
