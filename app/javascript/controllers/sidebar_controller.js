import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="sidebar"
export default class extends Controller {
  open(event) {
    event.preventDefault()
    document.querySelector("#sidebar").classList.remove("-translate-x-full")
    document.querySelector("#sidebar").classList.add("translate-x-0")

    document.querySelector("#sidebar-background").classList.remove("opacity-0", "pointer-events-none")
    document.querySelector("#sidebar-background").classList.add("opacity-100")
  }

  close(event) {
    event.preventDefault()
    document.querySelector("#sidebar").classList.remove("translate-x-0")
    document.querySelector("#sidebar").classList.add("-translate-x-64")

    document.querySelector("#sidebar-background").classList.remove("opacity-100")
    document.querySelector("#sidebar-background").classList.add("opacity-0", "pointer-events-none")
  }
}
