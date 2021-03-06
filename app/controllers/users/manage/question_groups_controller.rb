class Users::Manage::QuestionGroupsController < ApplicationController
  before_action :set_question_group, only: [:show, :edit, :update, :destroy, :preview]
  layout 'survey', only: [:preview]

  # GET /question_groups
  # GET /question_groups.json
  def index
    @question_groups = QuestionGroup.all
    respond_to do |format|
      format.html
      format.json {render json: @question_groups}
    end
  end

  # GET /question_groups/1
  # GET /question_groups/1.json
  def show
    @survey = Survey.find_by_id(params[:survey_id])
  end

  # GET /question_groups/new
  def new
    @question_group = QuestionGroup.new
  end

  # GET /question_groups/1/edit
  def edit
  end

  # POST /question_groups
  # POST /question_groups.json
  def create
    @question_group = QuestionGroup.new(question_group_params.to_h.merge :survey_id => question_group_params[:survey_id])
    respond_to do |format|
      if @question_group.save
        if params[:external].present?
          format.html { redirect_to request.referrer, flash: {success: 'Question group was successfully created.'} }
        else
          format.html { redirect_to @question_group, flash: {success: 'Question group was successfully created.'}}
        end
        format.json { render :show, status: :created, location: @question_group }
      else
        format.html { redirect_to request.referrer, flash: {danger: @question_group.errors}  }
        format.json { render json: @question_group.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @question_group.update(question_group_params)
        format.html { redirect_to request.referrer, flash: {success: 'Question group was successfully updated.' }}
        format.json { render :show, status: :ok, location: @question_group }
      else
        format.html { render :show }
        format.json { render json: @question_group.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @question_group.destroy
    respond_to do |format|
      format.html { redirect_to users_manage_survey_path(@question_group.survey_id), flash: {success: 'Question group was successfully destroyed.' }}
      format.json { head :no_content }
    end
  end

  def check_logic
    @verify = ErrorLogic::GroupLogic.call(params[:id])
    if @verify
      flash[:success] = 'This group doesnt have any logic error.'
      redirect_to request.referrer
    else
      flash[:danger] = 'Please verify your question answer.'
      redirect_to request.referrer
    end
  end

  def sort
    params[:question_group].each_with_index do |id, index|
      QuestionGroup.where(id: id).update_all position: index + 1
      @group = QuestionGroup.where(id: id).first
      Question.reorder_survey_position(@group.survey_id)
    end
    head :ok
  end

  def preview
    @survey = @question_group.survey
    params[:question_id] ||= @question_group.questions.first.id
    @question = Question.find_by_id(params[:question_id])
  end

  private

    def set_question_group
      @question_group = QuestionGroup.find(params[:id])
    end

    def question_group_params
      params.require(:question_group).permit(:position, :name, :description, :survey_id, :hidden)
    end
end
