import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="hidemodal"
export default class extends Controller {

  connect() {
    console.log("hello hide modal controller")
  }

  submitEnd(e) {
    if (e.detail.success) {
      this.hideModal()
    }
    console.log(e.detail.success)
  }

  hideModal(){
    this.element.remove()
  }
}
