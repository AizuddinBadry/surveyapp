class Users::Manage::QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy, :change_type]
  skip_before_action :verify_authenticity_token, only: :change_type


  # GET /questions
  # GET /questions.json
  def index
    @questions = Question.all
  end

  def show
  end

  # GET /questions/new
  def new
    @question = Question.new
    @question.question_answers.new
  end


  # POST /questions
  # POST /questions.json
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

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
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

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to users_manage_question_group_path(params[:group_id], survey_id: params[:survey_id]), flash: {success: 'Question was successfully destroyed.'} }
      format.json { head :no_content }
    end
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
      params.require(:question).permit(:question_group_id, :q_type, :code, :description, :help, :mandatory, :position, 
                                        question_answers_attributes: [:exact_value, :id])
    end


end
