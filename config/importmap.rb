# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "apexcharts" # @3.49.2
pin "chart.js" # @4.4.3
pin "@kurkle/color", to: "@kurkle--color.js" # @0.3.2
pin "@rails/ujs", to: "@rails--ujs.js" # @7.1.3
