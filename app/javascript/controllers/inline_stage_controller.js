import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["trigger", "form", "select"]

  connect() {
    this.showBadge()
  }

  open(event) {
    event.preventDefault()
    this.triggerTarget.hidden = true
    this.formTarget.hidden = false
    this.selectTarget.focus()
  }

  save() {
    this.formTarget.requestSubmit()
  }

  close() {
    this.showBadge()
  }

  showBadge() {
    this.triggerTarget.hidden = false
    this.formTarget.hidden = true
  }
}
