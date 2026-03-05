import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["rowCheckbox", "masterCheckbox", "modal", "backdrop", "leadIdsField", "selectedCount"]

  toggleAll(event) {
    const checked = event.currentTarget.checked
    this.rowCheckboxTargets.forEach((checkbox) => {
      checkbox.checked = checked
    })
    this.syncSelection()
  }

  syncSelection() {
    const ids = this.selectedIds()
    if (this.hasMasterCheckboxTarget) {
      this.masterCheckboxTarget.checked = this.rowCheckboxTargets.length > 0 && ids.length === this.rowCheckboxTargets.length
    }

    if (this.hasSelectedCountTarget) {
      const label = ids.length === 1 ? "lead selected" : "leads selected"
      this.selectedCountTarget.textContent = `${ids.length} ${label}`
    }
  }

  selectAllRows() {
    this.rowCheckboxTargets.forEach((checkbox) => {
      checkbox.checked = true
    })
    this.syncSelection()
  }

  clearSelection() {
    this.rowCheckboxTargets.forEach((checkbox) => {
      checkbox.checked = false
    })
    this.syncSelection()
  }

  openModal() {
    const ids = this.selectedIds()
    if (ids.length === 0) {
      window.alert("Select at least one lead.")
      return
    }

    this.leadIdsFieldTarget.value = ids.join(",")
    this.syncSelection()
    this.modalTarget.hidden = false
    this.backdropTarget.hidden = false
    document.body.classList.add("bulk-modal-open")
  }

  close() {
    if (!this.hasModalTarget || !this.hasBackdropTarget) return
    this.modalTarget.hidden = true
    this.backdropTarget.hidden = true
    document.body.classList.remove("bulk-modal-open")
  }

  syncBeforeSubmit() {
    this.leadIdsFieldTarget.value = this.selectedIds().join(",")
  }

  selectedIds() {
    return this.rowCheckboxTargets.filter((checkbox) => checkbox.checked).map((checkbox) => checkbox.value)
  }
}
