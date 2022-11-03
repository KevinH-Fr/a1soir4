import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="hidemodal"
export default class extends Controller {

  connect() {
    console.log("hello hide modal controller")
  }

  submitEnd(e) {
    if (e.detail.success) {
      this.hidePartial()
    }
    console.log(e.detail.success)
  }

  hidePartial(){
    this.element.remove()
  }
}
