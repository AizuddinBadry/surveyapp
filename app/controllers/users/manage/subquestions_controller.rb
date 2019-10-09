class Users::Manage::SubquestionsController < ApplicationController
  before_action :set_subquestion, only: [:show, :edit, :update, :destroy]

  def index
    @subquestions = Subquestion.all
  end

  def show
  end

  def new
    @subquestion = Subquestion.new
  end

  def edit
  end

  def create
    @subquestion = Subquestion.new(subquestion_params)

    respond_to do |format|
      if @subquestion.save
        format.html { redirect_to @subquestion, notice: 'Subquestion was successfully created.' }
        format.json { render :show, status: :created, location: @subquestion }
      else
        format.html { render :new }
        format.json { render json: @subquestion.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @subquestion.update(subquestion_params)
        format.html { redirect_to @subquestion, notice: 'Subquestion was successfully updated.' }
        format.json { render :show, status: :ok, location: @subquestion }
      else
        format.html { render :edit }
        format.json { render json: @subquestion.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @subquestion.destroy
    respond_to do |format|
      format.html { redirect_to subquestions_url, notice: 'Subquestion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_subquestion
      @subquestion = Subquestion.find(params[:id])
    end

    def subquestion_params
      params.require(:subquestion).permit(:question_id, :code, :value, :exact_value, :position)
    end
end
