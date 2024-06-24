import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="add-workout-plan"
export default class extends Controller {
  connect() {
    const sheet = document.querySelector('#new-workout-plan-sheet');
    const sheetOverlay = document.querySelector('#new-workout-plan-sheet-overlay');

    this.element.addEventListener('click', (e) => {
      console.log("open sheet");

      // show the sheet and its overlay
      sheet.classList.remove("hidden");
      sheetOverlay.classList.remove("hidden");
    });
  }
}
