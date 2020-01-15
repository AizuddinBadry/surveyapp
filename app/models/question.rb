class Question < ApplicationRecord
  mount_uploader :media, MediaUploader
  include ImageUploader::Attachment.new(:image)
  before_save :default_values
  after_destroy :reorder_question_position

  def default_values
    size = Question.where(question_group_id: self.question_group_id).size
    survey_question_size = Question.where(survey_id: self.survey_id).size
    self.position ||= size + 1
    self.survey_position ||= survey_question_size + 1
    self.column ||= 1
    self.randomize ||= false
    self.desc_question_code ||= 0
    self.help ||= ""
  end
  
  def reorder_question_position
    group = QuestionGroup.find_by_id self.question_group_id
    group.questions.order(position: :asc).each_with_index do |question, index|
      question.update position: index.to_i + 1
    end
    Question.reorder_survey_position(group.survey_id)
  end

  def self.reorder_survey_position(survey_id)
    survey = Survey.find_by_id survey_id
    survey.questions.joins(:question_group).order("question_groups.position ASC, questions.position ASC").each_with_index do |question, index|
      question.update!(survey_position: index.to_i + 1)
    end
  end

  def self.query_language(question, lang)
    @question = question.other_language["#{lang}"]
    if @question == false
      return nil
    else
      return @question
    end
  end

  def self.help_query_language(question, lang)
    @question = question.help_other_language["#{lang}"]
    if @question == false
      return nil
    else
      return @question
    end
  end

  def self.question_desc_query_language(question, lang)
    @question = question.question_desc_other_language["#{lang}"]
    if @question == false
      return nil
    else
      return @question
    end
  end

  def next
    Question.where("survey_position > ? AND question_group_id = ?", survey_position, question_group_id).first
  end

  def prev
    Question.where("survey_position < ? AND question_group_id = ?", survey_position, question_group_id).last
  end
  
  def name_dropdown
    "#{code} : [ #{q_type} ]  #{description}"
  end

  belongs_to :question_group, optional: true
  has_many :question_other_languages, dependent: :destroy
  belongs_to :survey, class_name: 'Survey', foreign_key: 'survey_id', optional: true
  has_many :question_answers, :dependent => :destroy 
  has_many :subquestions, :dependent => :destroy
  has_many :conditions, :dependent => :destroy
  has_many :survey_answers, :dependent => :destroy
  accepts_nested_attributes_for :question_answers
  accepts_nested_attributes_for :subquestions
  accepts_nested_attributes_for :conditions, allow_destroy: true
end
