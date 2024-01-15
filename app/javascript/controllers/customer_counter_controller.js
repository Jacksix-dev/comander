import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="customer-counter"
export default class extends Controller {
  static targets = ["countInput"];

  connect() {
    console.log("Connected to customer counter controller");
  }

  increment() {
    this.countInputTarget.stepUp();
  }

  decrement() {
    this.countInputTarget.stepDown();
  }
}
