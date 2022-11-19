// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "controllers"

//import "@hotwired/turbo-rails"
import { Turbo } from "@hotwired/turbo-rails"

Turbo.session.drive = true

require("@rails/activestorage").start()

//= require jquery_ujs
//= require jquery

//= require Chart.min
