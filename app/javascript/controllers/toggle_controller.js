import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "toggleable",
    "icon"
  ]

  toggle() {
    this.toggleableTarget.classList.toggle("hidden")
    this.iconTarget.classList.toggle("rotate-90")
  }
}
