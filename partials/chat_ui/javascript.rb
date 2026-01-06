def setup_chat_javascript
  # 1. Loader Controller
  create_file "app/javascript/controllers/loader_controller.js", <<~JS
    import { Controller } from "@hotwired/stimulus"

    export default class extends Controller {
      static targets = ["indicator"]

      connect() {
        // The parent container of the messages list
        this.container = this.indicatorTarget.parentElement

        // Observer to ensure loader stays at the bottom when new messages arrive
        this.observer = new MutationObserver(() => {
          if (!this.indicatorTarget.classList.contains("hidden")) {
            // If the loader is visible but not the last element, move it to the end
            if (this.container.lastElementChild !== this.indicatorTarget) {
              this.container.appendChild(this.indicatorTarget)
              this.scrollToBottom()
            }
          }
        })

        this.observer.observe(this.container, { childList: true })
      }

      disconnect() {
        if (this.observer) {
          this.observer.disconnect()
        }
      }

      show() {
        this.indicatorTarget.classList.remove("hidden")
        // Move to bottom immediately on show
        this.container.appendChild(this.indicatorTarget)
        this.scrollToBottom()
      }

      hide() {
        this.indicatorTarget.classList.add("hidden")
      }

      scrollToBottom() {
        if (this.container) {
          this.container.scrollTop = this.container.scrollHeight
        }
      }
    }
  JS

  # 2. Reset Form Controller
  create_file "app/javascript/controllers/reset_form_controller.js", <<~JS
    import { Controller } from "@hotwired/stimulus"

    export default class extends Controller {
      static targets = ["input"]

      clear() {
        // Small timeout ensures the form submission grabs the value before we clear it
        setTimeout(() => {
          this.element.reset()
          // If we have an explicit input target, focus it back
          if (this.hasInputTarget) {
            this.inputTarget.focus()
          }
        }, 10)
      }
    }
  JS

  # 3. Scroll Controller
  create_file "app/javascript/controllers/scroll_controller.js", <<~JS
    import { Controller } from "@hotwired/stimulus"
    export default class extends Controller {
      connect() {
        this.scrollToBottom()
        this.observer = new MutationObserver(() => this.scrollToBottom())
        this.observer.observe(this.element, { childList: true, subtree: true })
      }
      disconnect() { this.observer.disconnect() }
      scrollToBottom() { this.element.scrollTop = this.element.scrollHeight }
    }
  JS
end