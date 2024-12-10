import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="loading"
export default class extends Controller {
  static targets = ["loading"]

  displayLoading() {
    this.loadingTarget.classList.remove("hidden")
  }

  displayContent() {
    this.loadingTarget.classList.add("hidden")
  }
}
