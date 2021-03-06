class Survey < ApplicationRecord
  include ImageUploader.attachment(:image)
  before_save :default_values
  before_create :create_association
  validates_presence_of :title

  def create_association
    self.survey_languages.build name: 'English', survey_id: self.id
  end

  def default_values
    self.status ||= "inactive"
  end

  belongs_to :user
  has_one :survey_setting, dependent: :destroy
  has_many :question_groups, dependent: :destroy
  has_many :questions, class_name: 'Question', foreign_key: 'survey_id'
  has_many :survey_languages, dependent: :destroy
  has_many :quotas, dependent: :destroy
end
