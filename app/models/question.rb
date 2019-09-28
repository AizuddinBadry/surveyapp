class Question < ApplicationRecord
  include ImageUploader::Attachment.new(:image)
  belongs_to :question_group
  has_many :question_answers, :dependent => :delete_all 
  accepts_nested_attributes_for :question_answers
end
