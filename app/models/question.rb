class Question < ApplicationRecord
  include ImageUploader::Attachment.new(:image)
  before_save :default_values

  def default_values
    size = Question.where(question_group_id: self.question_group_id).size
    self.position ||= size + 1
  end


  belongs_to :question_group
  has_many :question_answers, :dependent => :delete_all 
  accepts_nested_attributes_for :question_answers
end
