import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["panel", "backdrop", "name", "meta", "activityForm", "followUpForm"]

  open(event) {
    const trigger = event.currentTarget
    const leadName = trigger.dataset.leadName
    const leadMobile = trigger.dataset.leadMobile
    const leadEmail = trigger.dataset.leadEmail
    const activityUrl = trigger.dataset.activityUrl
    const followUpUrl = trigger.dataset.followUpUrl

    this.nameTarget.textContent = leadName
    this.metaTarget.textContent = leadEmail ? `${leadMobile} · ${leadEmail}` : leadMobile
    this.activityFormTarget.action = activityUrl
    this.followUpFormTarget.action = followUpUrl

    this.panelTarget.hidden = false
    this.backdropTarget.hidden = false
    document.body.classList.add("lead-panel-open")
  }

  close() {
    this.panelTarget.hidden = true
    this.backdropTarget.hidden = true
    document.body.classList.remove("lead-panel-open")
  }
}
