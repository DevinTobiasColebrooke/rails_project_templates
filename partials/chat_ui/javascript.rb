def setup_chat_javascript
  # 1. Pin Marked
  append_to_file "config/importmap.rb", <<~RUBY
    pin "marked" # @12.0.0
  RUBY

  # 2. Loader Controller
  create_file "app/javascript/controllers/loader_controller.js", <<~JS
    import { Controller } from "@hotwired/stimulus"

    export default class extends Controller {
      static targets = ["indicator"]

      show() {
        this.indicatorTarget.classList.remove("hidden")
        this.scrollToBottom()
      }

      hide() {
        this.indicatorTarget.classList.add("hidden")
      }

      scrollToBottom() {
        const scrollContainer = document.getElementById("messages")
        if (scrollContainer) {
          scrollContainer.scrollTop = scrollContainer.scrollHeight
        }
      }
    }
  JS

  # 3. Markdown Controller
  create_file "app/javascript/controllers/markdown_controller.js", <<~JS
    import { Controller } from "@hotwired/stimulus"

    export default class extends Controller {
      connect() {
        if (window.marked) {
          this.render()
        } else {
          setTimeout(() => this.render(), 100)
        }
      }

      render() {
        this.element.innerHTML = window.marked.parse(this.element.innerText)
      }
    }
  JS

  # 4. Reset Form Controller
  create_file "app/javascript/controllers/reset_form_controller.js", <<~JS
    import { Controller } from "@hotwired/stimulus"

    export default class extends Controller {
      static targets = ["input"]

      clear() {
        setTimeout(() => {
          this.element.reset()
          if (this.hasInputTarget) {
            this.inputTarget.focus()
          }
        }, 10)
      }
    }
  JS

  # 5. Scroll Controller
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