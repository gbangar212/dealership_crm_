class LeadStagesController < ApplicationController
  before_action :set_stage, only: %i[edit update destroy]

  def index
    @lead_stages = LeadStage.order(:position)
  end

  def new
    @lead_stage = LeadStage.new(position: LeadStage.maximum(:position).to_i + 1)
  end

  def create
    @lead_stage = LeadStage.new(stage_params)

    if @lead_stage.save
      redirect_to lead_stages_path, notice: "Stage created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @lead_stage.update(stage_params)
      redirect_to lead_stages_path, notice: "Stage updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @lead_stage.destroy
    redirect_to lead_stages_path, notice: "Stage removed.", status: :see_other
  end

  private

  def set_stage
    @lead_stage = LeadStage.find(params[:id])
  end

  def stage_params
    params.require(:lead_stage).permit(:name, :position, :active)
  end
end
