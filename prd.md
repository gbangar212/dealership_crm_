Below is a complete **Product Requirements Document (PRD)** in Markdown format.
You can save this as `auto_crm_prd.md` and provide it directly to Codex for Rails 8 implementation.

---

# Auto Dealership Lead CRM

## Product Requirements Document (PRD)

Version 1.0

---

# 1. Product Overview

## 1.1 Purpose

Design and develop a **web-based CRM system** for an automobile dealership to manage inbound and outbound leads efficiently across the entire sales lifecycle.

The CRM will:

* Capture and manage new leads
* Track lead stages and activities
* Integrate with IVR and WhatsApp
* Improve response time and conversion
* Provide management visibility into performance

Target users:

* CRE (Customer Relationship Executive)
* Sales Managers
* Sales Executives
* Admin

---

# 2. Goals & Objectives

### Primary Goals

* Centralize all lead data
* Track every interaction (call, WhatsApp, follow-up)
* Prevent lead leakage
* Improve lead-to-booking conversion ratio
* Enable structured follow-up process
* Provide real-time reporting

### Success Metrics

* Lead response time < 5 minutes
* Follow-up adherence > 95%
* Increase conversion rate by 15%
* Zero lost/unassigned leads

---

# 3. User Roles

## 3.1 Admin

* Manage users & permissions
* Configure lead stages
* Configure IVR mapping
* Configure WhatsApp templates
* Access full reports

## 3.2 CRE

* Add and update leads
* Change lead stage
* Log call notes
* Schedule follow-ups
* Send WhatsApp messages

## 3.3 Sales Executive

* Receive assigned leads
* Update status
* Log activities
* Add booking details

## 3.4 Sales Manager

* View team performance
* Reassign leads
* Override stages
* View conversion reports

---

# 4. Lead Lifecycle & Stages

The CRM must support configurable stages, including but not limited to:

1. New Lead
2. Contacted
3. Follow-up Required
4. Interested
5. Test Drive Scheduled
6. Test Drive Done
7. Negotiation
8. Booking Confirmed
9. Delivered
10. Lost
11. Duplicate

Each stage must store:

* Timestamp of entry
* User who updated stage
* Notes
* Duration in stage

---

# 5. Core Data Model

## 5.1 Lead Fields

Based on dealership requirements, include:

### Lead Information

* Lead ID (auto-generated)
* Source (IVR / WhatsApp / Walk-in / Website / Referral / etc.)
* Sub-source
* Campaign Name
* Lead Creation Date
* Assigned CRE
* Assigned Sales Executive

### Customer Information

* Customer Name
* Mobile Number (primary)
* Alternate Number
* Email
* City
* Address

### Vehicle Interest

* Interested Model
* Variant
* Fuel Type
* Color Preference
* Budget Range

### Status Information

* Current Stage
* Lead Score
* Hot/Warm/Cold classification
* Expected Purchase Timeline

### Activity Tracking

* Last Call Date
* Last WhatsApp Date
* Next Follow-up Date
* Follow-up Count
* Notes (rich text)

### Booking Details (if applicable)

* Booking Amount
* Booking Date
* Payment Mode
* Delivery Date

---

# 6. Functional Requirements

---

# 6.1 Lead Management

* Create lead manually
* Auto-create lead from IVR
* Auto-create lead from WhatsApp
* Import leads via CSV
* Bulk assign leads
* Merge duplicate leads
* Lead search (mobile, name, model)
* Advanced filtering

---

# 6.2 Activity Management

* Log calls (manual entry + IVR auto-log)
* Auto-save call duration from IVR
* Add call disposition
* Schedule follow-ups
* Auto reminders (email + dashboard alerts)
* Timeline view per lead

Each lead must show a complete activity history timeline.

---

# 6.3 IVR Integration

## 6.3.1 Requirements

* Integrate with IVR provider (e.g., Exotel, Knowlarity, Twilio)
* On missed call:

  * Auto-create lead
  * Capture caller ID
* On connected call:

  * Log duration
  * Attach call recording URL
* Map IVR options to:

  * Model selection
  * Service inquiry
  * Sales inquiry

## 6.3.2 Call Flow

1. Customer calls dealership number
2. IVR captures input
3. CRM receives webhook
4. CRM creates/updates lead
5. Assign CRE automatically

---

# 6.4 WhatsApp Integration

## 6.4.1 Requirements

* Use WhatsApp Business API
* Send pre-approved templates
* Log inbound messages
* Attach media (brochure, pricing)
* Auto-create lead from inbound unknown number

## 6.4.2 WhatsApp Features

* Quick reply templates
* Automated first response
* Reminder messages
* Booking confirmation message
* Follow-up nudges

All WhatsApp conversations must be visible inside the lead timeline.

---

# 6.5 Automation Engine

## 6.5.1 Auto Assignment Rules

* Round-robin distribution
* Source-based routing
* Model-based routing

## 6.5.2 Follow-up Escalation

* If no activity in 24 hours → alert manager
* If no follow-up after X days → escalate
* Auto-move stage if inactive for Y days

---

# 6.6 Dashboard & Reports

## 6.6.1 CRE Dashboard

* My Leads
* Today’s Follow-ups
* Overdue Follow-ups
* Conversion Summary

## 6.6.2 Manager Dashboard

* Leads by Source
* Leads by Stage
* Conversion Funnel
* CRE Performance
* Call Metrics
* WhatsApp Response Metrics

## 6.6.3 Reports

* Daily Lead Report
* Stage Movement Report
* Lost Reason Analysis
* Test Drive Conversion
* Booking Conversion
* Revenue Forecast

Export formats:

* CSV
* Excel

---

# 6.7 Notifications

* New lead assigned
* Follow-up reminder
* Lead escalated
* Booking confirmed

Channels:

* In-app
* Email
* Optional SMS

---

# 7. Non-Functional Requirements

## 7.1 Performance

* Page load < 2 seconds
* Lead search < 1 second
* Handle 50,000+ leads

## 7.2 Security

* Role-based access control
* Encrypted data storage
* Secure API endpoints
* Audit logs for stage changes
* GDPR-style data protection

## 7.3 Availability

* 99.5% uptime
* Daily backups
* Disaster recovery plan

---

# 8. Technical Architecture (Rails 8)

## 8.1 Backend

* Ruby on Rails 8
* PostgreSQL
* Sidekiq for background jobs
* Redis for caching

## 8.2 Frontend

* Rails 8 + Hotwire (Turbo + Stimulus)
* Tailwind CSS

## 8.3 Integrations

* Webhook endpoints for:

  * IVR provider
  * WhatsApp API
* ActiveJob for processing webhooks

## 8.4 Suggested Data Models

* User
* Role
* Lead
* LeadStage
* Activity
* CallLog
* WhatsAppMessage
* Booking
* Campaign
* FollowUp
* EscalationRule

---

# 9. API Endpoints Required

* POST /api/leads (create lead)
* PATCH /api/leads/:id
* POST /api/ivr/webhook
* POST /api/whatsapp/webhook
* GET /api/reports
* POST /api/assign

---

# 10. UI Pages

1. Login
2. Dashboard
3. Lead List View
4. Lead Detail View
5. Activity Timeline
6. Reports
7. Settings
8. User Management
9. IVR Settings
10. WhatsApp Template Manager

---

# 11. Future Enhancements

* AI lead scoring
* Auto WhatsApp chatbot
* Call sentiment analysis
* Integration with DMS
* Payment gateway integration
* Test drive route tracking
* Mobile app

---

# 12. MVP Scope

For Phase 1:

* Lead management
* Stage tracking
* IVR integration
* WhatsApp integration
* Dashboard
* Reporting
* Role management

---

# 13. Risks & Mitigation

| Risk                | Mitigation                     |
| ------------------- | ------------------------------ |
| Lead duplication    | Mobile-based unique constraint |
| Missed follow-ups   | Auto reminders                 |
| Poor data quality   | Mandatory fields validation    |
| Integration failure | Retry logic + logging          |

---

# 14. Acceptance Criteria

* Lead auto-created from IVR
* WhatsApp messages logged in timeline
* Stage transitions tracked
* Reports generate correctly
* Role-based restrictions enforced
* Follow-up reminders working

---

# 15. Deployment

* Dockerized Rails 8 app
* Hosted on AWS / DigitalOcean
* CI/CD pipeline
* Daily DB backup

---

# End of PRD

---

If you would like, I can now:

* Convert this into a **database schema blueprint**
* Generate a **Rails 8 folder structure**
* Write **initial migrations and models**
* Or design the **ER diagram** for implementation clarity
