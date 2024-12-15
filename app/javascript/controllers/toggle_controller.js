import { Controller } from "@hotwired/stimulus"
import { put } from "@rails/request.js"

export default class extends Controller {
  static values = {
    toggleable: String,
    toggleableId: Number
  }

  static targets = [
    "toggleable",
    "icon"
  ]

  toggle() {
    this.toggleableTarget.classList.toggle("hidden")
    this.iconTarget.classList.toggle("rotate-90")

    this.persistToggle(this.toggleableValue, this.toggleableIdValue)
  }

  async persistToggle(toggleable, toggleableId) {
    await put(`/${toggleable}/${toggleableId}/toggle`)
  }
}
