import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="loading"
export default class extends Controller {
  static targets = [
    "loading",
    "content"
  ]

  displayLoading() {
    this.loadingTarget.classList.remove("hidden")
    this.contentTarget.classList.add("hidden")
  }

  displayContent() {
    this.loadingTarget.classList.add("hidden")
    this.contentTarget.classList.remove("hidden")
  }
}
