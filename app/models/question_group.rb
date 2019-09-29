class QuestionGroup < ApplicationRecord
  validates_presence_of :name
  belongs_to :survey
  has_many :questions, :dependent => :destroy
  has_many :group_error_logics, :dependent => :destroy
end
