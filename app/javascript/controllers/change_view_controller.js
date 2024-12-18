import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="change-view"
export default class extends Controller {
  static values = {
    type: String
  }

  changeView() {
    const items = document.getElementById("items")

    if (this.typeValue == "list") {
      items.classList.remove("grid")
      items.classList.remove("md:grid-cols-2")
      items.classList.remove("lg:grid-cols-4")
      items.classList.remove("gap-2")
    } else {
      items.classList.add("grid")
      items.classList.add("md:grid-cols-2")
      items.classList.add("lg:grid-cols-4")
      items.classList.add("gap-2")
    }
  }
}
