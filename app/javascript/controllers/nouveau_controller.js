import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="new"
export default class extends Controller {
  static targets = ["nouveauContent", "openNouveau", "closeNouveau"]

  connect() {
    this.nouveauContentTarget.hidden = true
    this.closeNouveauTarget.hidden = true
    console.log("hello from stiumuls nouveau_controller")
  }

  openNouveau() {
    this.nouveauContentTarget.hidden = false
    this.openNouveauTarget.hidden = true
    this.closeNouveauTarget.hidden = false
  }

  closeNouveau() {
    this.nouveauContentTarget.hidden = true
    this.openNouveauTarget.hidden = false
    this.closeNouveauTarget.hidden = true
  }
}
