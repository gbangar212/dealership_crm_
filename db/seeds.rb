# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

roles = ["Admin", "CRE", "Sales Executive", "Sales Manager"]
roles.each { |name| Role.find_or_create_by!(name: name) }

stage_names = [
  "New Lead",
  "Contacted",
  "Follow-up Required",
  "Interested",
  "Test Drive Scheduled",
  "Test Drive Done",
  "Negotiation",
  "Booking Confirmed",
  "Delivered",
  "Lost",
  "Duplicate"
]

stage_names.each_with_index do |name, index|
  LeadStage.find_or_create_by!(name: name) do |stage|
    stage.position = index + 1
    stage.active = true
  end
end

if User.count.zero?
  admin_role = Role.find_by(name: "Admin")
  cre_role = Role.find_by(name: "CRE")
  sales_role = Role.find_by(name: "Sales Executive")
  manager_role = Role.find_by(name: "Sales Manager")

  User.create!(
    first_name: "Ava",
    last_name: "Admin",
    email: "admin@dealership.local",
    role: admin_role
  )

  User.create!(
    first_name: "Chris",
    last_name: "CRE",
    email: "cre@dealership.local",
    role: cre_role
  )

  User.create!(
    first_name: "Sam",
    last_name: "Sales",
    email: "sales@dealership.local",
    role: sales_role
  )

  User.create!(
    first_name: "Maya",
    last_name: "Manager",
    email: "manager@dealership.local",
    role: manager_role
  )
end

default_stage = LeadStage.order(:position).first
stages = LeadStage.order(:position).to_a
users = User.order(:last_name).to_a

sample_leads = [
  { lead_number: "LEAD1001", customer_name: "Aarav Patel", mobile_number: "9000000001", email: "aarav@example.com", city: "Mumbai", source: "website", interested_model: "Swift", temperature: "warm" },
  { lead_number: "LEAD1002", customer_name: "Diya Sharma", mobile_number: "9000000002", email: "diya@example.com", city: "Delhi", source: "whatsapp", interested_model: "Creta", temperature: "hot" },
  { lead_number: "LEAD1003", customer_name: "Rohan Mehta", mobile_number: "9000000003", email: "rohan@example.com", city: "Pune", source: "walk_in", interested_model: "City", temperature: "cold" },
  { lead_number: "LEAD1004", customer_name: "Anaya Singh", mobile_number: "9000000004", email: "anaya@example.com", city: "Jaipur", source: "ivr", interested_model: "Nexon", temperature: "warm" },
  { lead_number: "LEAD1005", customer_name: "Vihaan Iyer", mobile_number: "9000000005", email: "vihaan@example.com", city: "Chennai", source: "referral", interested_model: "Seltos", temperature: "hot" },
  { lead_number: "LEAD1006", customer_name: "Sara Khan", mobile_number: "9000000006", email: "sara@example.com", city: "Hyderabad", source: "website", interested_model: "Baleno", temperature: "warm" },
  { lead_number: "LEAD1007", customer_name: "Kabir Rao", mobile_number: "9000000007", email: "kabir@example.com", city: "Bengaluru", source: "whatsapp", interested_model: "XUV700", temperature: "hot" },
  { lead_number: "LEAD1008", customer_name: "Ishita Bose", mobile_number: "9000000008", email: "ishita@example.com", city: "Kolkata", source: "walk_in", interested_model: "Venue", temperature: "cold" },
  { lead_number: "LEAD1009", customer_name: "Arjun Verma", mobile_number: "9000000009", email: "arjun@example.com", city: "Surat", source: "ivr", interested_model: "Harrier", temperature: "warm" },
  { lead_number: "LEAD1010", customer_name: "Meera Nair", mobile_number: "9000000010", email: "meera@example.com", city: "Kochi", source: "referral", interested_model: "Innova", temperature: "hot" }
]

sample_leads.each_with_index do |attrs, index|
  Lead.create!(
    attrs.merge(
      current_stage: stages[index % stages.length] || default_stage,
      assigned_cre: users.first,
      assigned_sales_exec: users.second,
      next_follow_up_on: Date.current + (index + 1).days
    )
  )
end
