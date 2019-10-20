class Survey < ApplicationRecord
  include ImageUploader.attachment(:image)
  before_create :create_association
  validates_presence_of :title

  def create_association
    self.survey_languages.build name: 'English', survey_id: self.id
  end

  belongs_to :user
  has_one :survey_setting, dependent: :destroy
  has_many :question_groups, dependent: :destroy
  has_many :questions, class_name: 'Question', foreign_key: 'survey_id'
  has_many :survey_languages
end
