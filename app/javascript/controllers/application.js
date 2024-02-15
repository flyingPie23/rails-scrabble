import { Application } from "@hotwired/stimulus"
import { definitionsFromContext } from "stimulus/webpack-helpers"

const application = Application.start()
const context = require.context("./controllers", true, /\.js$/)

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

application.load(definitionsFromContext(context))

export { application }
