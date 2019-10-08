class SubquestionsController < ApplicationController
  before_action :set_subquestion, only: [:show, :edit, :update, :destroy]

  # GET /subquestions
  # GET /subquestions.json
  def index
    @subquestions = Subquestion.all
  end

  # GET /subquestions/1
  # GET /subquestions/1.json
  def show
  end

  # GET /subquestions/new
  def new
    @subquestion = Subquestion.new
  end

  # GET /subquestions/1/edit
  def edit
  end

  # POST /subquestions
  # POST /subquestions.json
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

  # PATCH/PUT /subquestions/1
  # PATCH/PUT /subquestions/1.json
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

  # DELETE /subquestions/1
  # DELETE /subquestions/1.json
  def destroy
    @subquestion.destroy
    respond_to do |format|
      format.html { redirect_to subquestions_url, notice: 'Subquestion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subquestion
      @subquestion = Subquestion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def subquestion_params
      params.require(:subquestion).permit(:question_id, :code, :value, :exact_value, :position)
    end
end
