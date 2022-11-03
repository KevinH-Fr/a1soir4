import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="hidepartial"
export default class extends Controller {

  connect() {
    console.log("hello hide partial controller")
  }

 

  //submitEnd(e) {
  //  if (e.detail.success) {
  //    this.hidePartial()
  //  }
  //  console.log(e.detail.success)
 // }

 // hidePartial(){
 //   this.element.remove()
 // }
}
