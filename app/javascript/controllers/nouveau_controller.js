import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="new"
export default class extends Controller {
  static targets = ["nouveauContent", "openNouveau", "closeNouveau", "hidePartial"]

  connect() {
    this.nouveauContentTarget.hidden = true
    this.closeNouveauTarget.hidden = true
    console.log("hello from stiumuls nouveau_controller")
  }


  openNouveau() {
    this.nouveauContentTarget.hidden = false
    this.openNouveauTarget.hidden = true
    this.closeNouveauTarget.hidden = false
    console.log("open nouveau")
  }

  closeNouveau() {
    this.nouveauContentTarget.hidden = true 
    this.openNouveauTarget.hidden = false
    this.closeNouveauTarget.hidden = true
    console.log("close nouveau")
  }

  submitEnd(e) {
    if (e.detail.success) {
      this.hidePartial()
    }
    console.log(e.detail.success)
  }

  hidePartial() {
   this.element.remove()
   this.nouveauContentTarget.hidden = true 
   this.openNouveauTarget.hidden = false
   this.closeNouveauTarget.hidden = true
  
  }

}
