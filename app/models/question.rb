class Question < ApplicationRecord
  include ImageUploader::Attachment.new(:image)
  before_save :default_values

  def default_values
    size = Question.where(question_group_id: self.question_group_id).size
    self.position ||= size + 1
  end


  def name_dropdown
    "#{code} : [ #{q_type} ]  #{description}"
  end



  belongs_to :question_group, optional: true
  has_many :question_answers, :dependent => :destroy 
  has_many :subquestions, :dependent => :destroy
  accepts_nested_attributes_for :question_answers
  accepts_nested_attributes_for :subquestions
end
