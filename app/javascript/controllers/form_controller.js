import { Controller } from "@hotwired/stimulus"
// Connects to data-controller="form"
export default class extends Controller {
  static targets = ['actions']

  resetForm() {
    this.element.reset()
  }
  connect() { }
}