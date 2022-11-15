import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="hidemodal"
export default class extends Controller {

  connect() {
    console.log("hello hide modal controller")
  }


  hideModal(){
    this.element.remove()
  }
}
