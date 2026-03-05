class LeadsController < ApplicationController
  before_action :set_lead, only: %i[show edit update destroy]

  def index
    @leads = Lead.includes(:current_stage, :assigned_cre, :assigned_sales_exec)

    if params[:stage_id].present?
      @leads = @leads.where(current_stage_id: params[:stage_id])
    end

    if params[:source].present?
      @leads = @leads.where(source: params[:source])
    end

    if params[:assigned_id].present?
      @leads = @leads.where("assigned_cre_id = ? OR assigned_sales_exec_id = ?", params[:assigned_id], params[:assigned_id])
    end

    if params[:model].present?
      @leads = @leads.where(interested_model: params[:model])
    end

    if params[:created_date].present?
      created_date = parse_date(params[:created_date])
      @leads = @leads.where(created_at: created_date.all_day) if created_date
    end

    @stages = LeadStage.order(:position)
    @sources = Lead::SOURCES
    @assignees = User.order(:last_name, :first_name)
    @models = Lead.where.not(interested_model: [nil, ""]).distinct.order(:interested_model).pluck(:interested_model)

    @sort = sort_key(params[:sort])
    @direction = sort_direction(params[:direction])
    apply_sort
  end

  def show
    @activities = @lead.activities.order(occurred_at: :desc)
    @follow_ups = @lead.follow_ups.order(due_on: :asc)
    @stage_transitions = @lead.stage_transitions.includes(:from_stage, :to_stage, :user).order(created_at: :desc)

    @activity = Activity.new(lead: @lead, occurred_at: Time.zone.now)
    @follow_up = FollowUp.new(lead: @lead, due_on: Date.current)
    @stage_transition = LeadStageTransition.new(lead: @lead)
  end

  def new
    @lead = Lead.new(current_stage: LeadStage.order(:position).first)
  end

  def create
    @lead = Lead.new(lead_params)

    if @lead.save
      redirect_to @lead, notice: "Lead was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @lead.update(lead_params)
      if params[:from_list].present?
        redirect_back fallback_location: leads_path, notice: "Lead was successfully updated."
      else
        redirect_to @lead, notice: "Lead was successfully updated."
      end
    else
      if params[:from_list].present?
        redirect_back fallback_location: leads_path, alert: @lead.errors.full_messages.to_sentence
      else
        render :edit, status: :unprocessable_entity
      end
    end
  end

  def destroy
    @lead.destroy
    redirect_to leads_path, notice: "Lead was successfully removed.", status: :see_other
  end

  def bulk_update_sales_exec
    lead_ids = parsed_lead_ids
    sales_exec_id = params[:assigned_sales_exec_id].presence

    if lead_ids.empty?
      redirect_back fallback_location: leads_path, alert: "Select at least one lead."
      return
    end

    if sales_exec_id.present? && !User.exists?(id: sales_exec_id)
      redirect_back fallback_location: leads_path, alert: "Selected sales rep is invalid."
      return
    end

    updated_count = Lead.where(id: lead_ids).update_all(assigned_sales_exec_id: sales_exec_id, updated_at: Time.current)
    redirect_back fallback_location: leads_path, notice: "Updated sales rep for #{updated_count} lead(s)."
  end

  private

  def set_lead
    @lead = Lead.find(params[:id])
  end

  def parse_date(value)
    Date.iso8601(value)
  rescue ArgumentError
    nil
  end

  def parsed_lead_ids
    params[:lead_ids_csv].to_s.split(",").map { |id| Integer(id, 10) rescue nil }.compact.uniq
  end

  def sort_key(value)
    allowed = %w[lead contact created_date days_since_created updated_date days_since_updated model stage source assigned]
    allowed.include?(value) ? value : "created_date"
  end

  def sort_direction(value)
    %w[asc desc].include?(value) ? value : "desc"
  end

  def apply_sort
    case @sort
    when "lead"
      @leads = @leads.order(customer_name: @direction)
    when "contact"
      @leads = @leads.order(mobile_number: @direction)
    when "created_date", "days_since_created"
      @leads = @leads.order(created_at: @direction)
    when "updated_date", "days_since_updated"
      @leads = @leads.order(updated_at: @direction)
    when "model"
      @leads = @leads.order(interested_model: @direction)
    when "stage"
      @leads = @leads.order(current_stage_id: @direction)
    when "source"
      @leads = @leads.order(source: @direction)
    when "assigned"
      @leads = @leads.order(Arel.sql("assigned_cre_id #{@direction}, assigned_sales_exec_id #{@direction}"))
    end
  end

  def lead_params
    params.require(:lead).permit(
      :lead_number,
      :source,
      :sub_source,
      :campaign_name,
      :current_stage_id,
      :assigned_cre_id,
      :assigned_sales_exec_id,
      :customer_name,
      :mobile_number,
      :alternate_number,
      :email,
      :state,
      :city,
      :customer_occupation,
      :company_name,
      :address,
      :interested_model,
      :variant,
      :fuel_type,
      :color_preference,
      :budget_range,
      :purchase_type,
      :is_exchange,
      :competition_car,
      :finance_status,
      :lead_score,
      :temperature,
      :expected_purchase_on,
      :last_call_at,
      :last_whatsapp_at,
      :next_follow_up_on,
      :follow_up_count,
      :notes,
      :booking_amount,
      :booking_date,
      :payment_mode,
      :delivery_date
    )
  end
end
