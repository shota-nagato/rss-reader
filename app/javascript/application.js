// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"

Turbo.StreamActions.redirect = function () {
  Turbo.visit(this.target)
}
