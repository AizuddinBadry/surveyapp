class Users::Manage::QuestionAnswersController < ApplicationController
  before_action :set_question_answer, only: [:show, :edit, :update, :destroy]

  # GET /question_answers
  # GET /question_answers.json
  def index
    @question_answers = QuestionAnswer.all
  end

  def sort
    params[:question_answer].each_with_index do |id, index|
      QuestionAnswer.where(id: id).update_all position: index + 1
    end
    head :ok
  end

  # GET /question_answers/1
  # GET /question_answers/1.json
  def show
  end

  # GET /question_answers/new
  def new
    @question_answer = QuestionAnswer.new
  end

  # POST /question_answers
  # POST /question_answers.json
  def create
    @question_answer = QuestionAnswer.new(question_answer_params)
    respond_to do |format|
      if @question_answer.save
        format.html { redirect_to @question_answer, notice: 'Question answer was successfully created.' }
        format.json { render :show, status: :created, location: @question_answer }
        format.js {render json: @question_answer}
      else
        format.html { render :new }
        format.json { render json: @question_answer.errors, status: :unprocessable_entity }
        format.js { render json: @question_answer.errors }
      end
    end
  end

  # PATCH/PUT /question_answers/1
  # PATCH/PUT /question_answers/1.json
  def update
    respond_to do |format|
      if @question_answer.update(question_answer_params)
        format.html { redirect_to @question_answer, notice: 'Question answer was successfully updated.' }
        format.json { render :show, status: :ok, location: @question_answer }
      else
        format.html { render :edit }
        format.json { render json: @question_answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /question_answers/1
  # DELETE /question_answers/1.json
  def destroy
    @question_answer.destroy
    respond_to do |format|
      format.html { redirect_to question_answers_url, notice: 'Question answer was successfully destroyed.' }
      format.json { head :no_content }
      format.js {head :ok}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question_answer
      @question_answer = QuestionAnswer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_answer_params
      params.require(:question_answer).permit(:question_id, :code, :value, :exact_value)
    end
end
