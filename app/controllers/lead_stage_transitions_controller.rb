class LeadStageTransitionsController < ApplicationController
  def create
    lead = Lead.find(params[:lead_id])
    from_stage = lead.current_stage

    transition = lead.stage_transitions.new(transition_params)
    transition.from_stage = from_stage

    if transition.save
      lead.update!(current_stage: transition.to_stage)
      redirect_to lead, notice: "Stage updated to #{transition.to_stage.name}."
    else
      redirect_to lead, alert: "Could not update stage."
    end
  end

  private

  def transition_params
    params.require(:lead_stage_transition).permit(:to_stage_id, :user_id, :notes)
  end
end
