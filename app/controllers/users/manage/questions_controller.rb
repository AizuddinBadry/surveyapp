class Users::Manage::QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy, :change_type, :preview]
  skip_before_action :verify_authenticity_token, only: :change_type
  layout 'survey', only: [:preview]

  def index
    @questions = Question.all
  end

  def show
    @languages = SurveyLanguage.where(survey_id: @question.survey_id).order(created_at: :asc)
    @question.conditions.build if @question.conditions.nil?
  end

  def new
    @question = Question.new
    @question.question_answers.new
  end

  def create
    if Question::Exists.new(question_params[:code], question_params[:question_group_id])
      flash[:warning] = 'This code is exists. Please use unique code for each question.'
      redirect_to request.referrer
    else
      @question = Question.new(question_params)
      respond_to do |format|
        if @question.save
          format.html { redirect_to @question, notice: 'Question was successfully created.' }
          format.json { render :show, status: :created, location: @question }
        else
          format.html { render :new }
          format.json { render json: @question.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def update
    @current = Question.where(question_group_id: @question.question_group_id, code: question_params[:code]).first
    if @current.present? && @current != @question
      flash[:danger] = 'Please use unique code for each question.'
      redirect_to request.referrer
    else
      respond_to do |format|
        if @question.update(question_params)
          Question.reorder_survey_position(@question.survey_id)
          format.html { redirect_to request.referrer, flash: {success: 'Question was successfully updated.' }}
          format.json { render :show, status: :ok, location: @question }
        else
          format.html { render :edit }
          format.json { render json: @question.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def destroy
    @group_id = @question.question_group_id
    @survey_id = @question.survey_id
    @question.destroy
    Question.reorder_survey_position(@survey_id)
    respond_to do |format|
      format.html { redirect_to users_manage_question_group_path(@group_id), flash: {success: 'Question was successfully destroyed.'} }
      format.json { head :no_content }
    end
  end

  def preview
    @question_group = @question.question_group
    @preview_mode = 'Question'
    @survey = Survey.find_by_id(@question.survey_id)
  end

  def change_type
    if @question.update q_type: params[:type]
      flash[:success] = 'Successful updated question type.'
      redirect_to request.referrer
    else
      flash[:danger] = @question.errors.full_messages.first
      redirect_to request.referrer
    end
  end

  private
    def set_question
      @question = Question.find(params[:id])
    end

    def question_params
      meta_keys_question = params.require(:question).fetch(:other_language, {}).keys
      params.require(:question).permit(:question_group_id, :q_type, :code, :description, :help, 
                                        :mandatory, :logic, :position,:q_desc ,:d_qcode , :limit, :structure,
                                        :enable_other_1, :enable_other_2, :other_language => meta_keys_question,
                                        question_answers_attributes: [:exact_value, :id, :code, :display_input_box_1, :display_input_box_2,
                                                                      :input_box_1_label, :input_box_2_label, :input_box_1_type, :input_box_2_type,
                                                                      :other_language => {}], 
                                        subquestions_attributes: [:exact_value, :id, :code])

    end


end
