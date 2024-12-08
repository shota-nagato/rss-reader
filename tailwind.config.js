module.exports = {
  content: [
    './app/components/**/*.html.erb',
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  theme: {
    extend: {
      colors: {
        primary: "#36a934",
        "primary-light": "#f1fcf1"
      }
    }
  }
}
