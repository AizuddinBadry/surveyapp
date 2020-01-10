class QuestionGroup < ApplicationRecord
  after_destroy :reorder_group_position

  def reorder_group_position
    survey = Survey.find_by_id self.survey_id
    survey.question_groups.where(hidden: false).order(position: :asc).each_with_index do |group, index|
      group.update position: index.to_i + 1
    end
  end
  

  validates_presence_of :name
  belongs_to :survey
  has_many :questions, :dependent => :destroy
  has_many :group_error_logics, :dependent => :destroy
end
