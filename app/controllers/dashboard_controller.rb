class DashboardController < ApplicationController
  def index
    @total_leads = Lead.count
    @new_this_week = Lead.where(created_at: Time.current.beginning_of_week..Time.current).count
    @new_this_month = Lead.where(created_at: Time.current.beginning_of_month..Time.current).count

    lost_stage = LeadStage.find_by(name: "Lost")
    duplicate_stage = LeadStage.find_by(name: "Duplicate")
    delivered_stage = LeadStage.find_by(name: "Delivered")

    closed_stage_ids = [lost_stage&.id, duplicate_stage&.id, delivered_stage&.id].compact

    @lost_count = lost_stage ? Lead.where(current_stage_id: lost_stage.id).count : 0
    @delivered_count = delivered_stage ? Lead.where(current_stage_id: delivered_stage.id).count : 0
    @active_count = closed_stage_ids.empty? ? @total_leads : Lead.where.not(current_stage_id: closed_stage_ids).count

    @overdue_follow_ups = FollowUp.where(status: "pending").where("due_on < ?", Date.current).count
    @follow_ups_due_week = FollowUp.where(due_on: Date.current..(Date.current + 6)).count

    @conversion_rate = if @total_leads.positive?
                         ((@delivered_count.to_f / @total_leads) * 100).round(1)
                       else
                         0
                       end

    @stage_stats = LeadStage.order(:position).map do |stage|
      [stage.name, stage.leads.count]
    end
    @stage_max = [@stage_stats.map(&:last).max, 1].max

    @source_stats = Lead.group(:source).count.map do |source, count|
      [source.presence || "Unknown", count]
    end
    @source_max = [@source_stats.map(&:last).max, 1].max

    @follow_up_stats = (0..6).map do |offset|
      date = Date.current + offset
      [date, FollowUp.where(due_on: date).count]
    end
    @follow_up_max = [@follow_up_stats.map(&:last).max, 1].max
  end
end
