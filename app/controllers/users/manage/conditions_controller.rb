class Users::Manage::ConditionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token


  # GET /conditions
  # GET /conditions.json
  def index
  end

  def show
    @result_condition = Condition.where(question_id: params[:id])
    @survey = Survey.where(user_id: current_user.id).first
    @questions = Question.joins(:question_group).where(question_groups: {survey_id: @survey.id})
     @questions.each do |question|
       @answer =  QuestionAnswer.joins(:question).where(questions: {question_group_id: question.question_group.id}) 
     end
    

  end

  # GET /conditions/new
  def new
    @condition = Condition.new
  end


  # POST /conditions
  # POST /conditions.json
  def create
    @condition = Condition.new(question_params)
    respond_to do |format|
      if @condition.save
        format.html { redirect_to request.referrer, notice: 'Condition was successfully created.' }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new }
        format.json { render json: @condition.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    respond_to do |format|
      if @condition.update(question_params)
        format.html { redirect_to request.referrer, flash: {success: 'Question was successfully updated.' }}
        format.json { render :show, status: :ok, location: @condition }
      else
        format.html { render :edit }
        format.json { render json: @condition.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @group_id = @question.group_id
    @question.destroy
    respond_to do |format|
      format.html { redirect_to users_manage_question_group_path(@group_id), flash: {success: 'Question was successfully destroyed.'} }
      format.json { head :no_content }
    end
  end


  private
    def set_question
      @condition = Condition.new
      @question = Question.find(params[:id])
    end

    def question_params
      params.require(:condition).permit(:question_id, :condition_question_id, :method, :value, :scenario )

    end


end

