import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="status-toggle"
export default class extends Controller {
  static targets = ["checkbox"]

  connect() {
  }

    toggle() {
    const currentStatus = this.checkboxTarget.checked ? 'complete' : 'pending';
    const newStatus = currentStatus === 'complete' ? 'pending' : 'complete';
    
    fetch(this.data.get("url"), {
      method: "PATCH",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").getAttribute("content")
      },
      body: JSON.stringify({ status: newStatus })
    })
    .then(response => {
      if (response.ok) {
        this.checkboxTarget.checked = newStatus === 'complete';
      } else {
        console.error("Failed to update status");
      }
    });
  }
}
