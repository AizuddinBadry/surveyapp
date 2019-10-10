class Users::Manage::QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy, :change_type, :preview]
  skip_before_action :verify_authenticity_token, only: :change_type
  layout 'survey', only: [:preview]

  def index
    @questions = Question.all
  end

  def show
  end

  def new
    @question = Question.new
    @question.question_answers.new
  end

  def create
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

  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to request.referrer, flash: {success: 'Question was successfully updated.' }}
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @group_id = @question.question_group_id
    @question.destroy
    respond_to do |format|
      format.html { redirect_to users_manage_question_group_path(@group_id), flash: {success: 'Question was successfully destroyed.'} }
      format.json { head :no_content }
    end
  end

  def preview
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
      params.require(:question).permit(:question_group_id, :q_type, :code, :description, :help, :mandatory, :position, :limit,
                                        question_answers_attributes: [:exact_value, :id, :code], 
                                        subquestions_attributes: [:exact_value, :id, :code])

    end


end
