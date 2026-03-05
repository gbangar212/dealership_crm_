class FollowUpsController < ApplicationController
  def create
    lead = Lead.find(params[:lead_id])
    follow_up = lead.follow_ups.new(follow_up_params)

    if follow_up.save
      if follow_up.status == "pending"
        lead.update(next_follow_up_on: follow_up.due_on, follow_up_count: lead.follow_up_count + 1)
      end

      if params[:from_list].present?
        redirect_back fallback_location: leads_path, notice: "Follow-up scheduled."
      else
        redirect_to lead, notice: "Follow-up scheduled."
      end
    else
      if params[:from_list].present?
        redirect_back fallback_location: leads_path, alert: "Could not schedule follow-up."
      else
        redirect_to lead, alert: "Could not schedule follow-up."
      end
    end
  end

  def update
    follow_up = FollowUp.find(params[:id])

    if follow_up.update(follow_up_params)
      redirect_to follow_up.lead, notice: "Follow-up updated."
    else
      redirect_to follow_up.lead, alert: "Could not update follow-up."
    end
  end

  private

  def follow_up_params
    params.require(:follow_up).permit(:user_id, :due_on, :status, :notes, :completed_at)
  end
end
