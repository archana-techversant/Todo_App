import { Controller } from "@hotwired/stimulus"
// Connects to data-controller="confirmation"
export default class extends Controller {
  static targets = ['actions']

  delete(event) {
    let confirmed = confirm("Are you sure?")
    if(!confirmed) {
      event.preventDefault()
   }
  }
  connect() {
  }
}
