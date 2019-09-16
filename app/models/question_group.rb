class QuestionGroup < ApplicationRecord
  validates_presence_of :name
  belongs_to :survey
  has_many :questions, :dependent => :destroy
end
