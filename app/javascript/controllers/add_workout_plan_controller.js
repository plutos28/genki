import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="add-workout-plan"
export default class extends Controller {
  connect() {
    this.element.addEventListener('click', (e) => {
      console.log("open sheet");
    });
  }
}
