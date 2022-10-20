import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="form-element"
export default class extends Controller {

  static targets = ["submitbtn"]
  connect() {
    this.submitbtnTarget.hidden = true
    this.submitbtnTarget.click()
    console.log('hello from stimulus form element controller')
  } 

  remotesubmit() {
    this.submitbtnTarget.click()
  }


}
