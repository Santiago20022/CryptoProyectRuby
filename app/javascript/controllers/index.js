import { application } from "../application"

// Aquí no necesitas `@hotwired/stimulus-loading`
import { definitionsFromContext } from "@hotwired/stimulus-webpack-helpers"

const context = require.context(".", true, /\.js$/)
application.load(definitionsFromContext(context))
