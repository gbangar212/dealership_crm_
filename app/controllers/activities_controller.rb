class ActivitiesController < ApplicationController
  def create
    lead = Lead.find(params[:lead_id])
    activity = lead.activities.new(activity_params)

    if activity.save
      if activity.kind == "call"
        lead.update(last_call_at: activity.occurred_at)
      elsif activity.kind == "whatsapp"
        lead.update(last_whatsapp_at: activity.occurred_at)
      end

      if params[:from_list].present?
        redirect_back fallback_location: leads_path, notice: "Activity logged."
      else
        redirect_to lead, notice: "Activity logged."
      end
    else
      if params[:from_list].present?
        redirect_back fallback_location: leads_path, alert: "Could not log activity."
      else
        redirect_to lead, alert: "Could not log activity."
      end
    end
  end

  private

  def activity_params
    params.require(:activity).permit(:user_id, :kind, :occurred_at, :notes, :duration_seconds)
  end
end
