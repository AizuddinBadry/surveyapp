class Question < ApplicationRecord
  belongs_to :question_group
  has_many :question_answers, :dependent => :delete_all 
end
