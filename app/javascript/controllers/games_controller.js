import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="games"
export default class extends Controller {
  connect() {
  }
  static targets = [ "name", "output" ]
  alert()
  greet() {
    this.outputTarget.textContent =
      `Hello, ${this.nameTarget.value}!`
  }
}
